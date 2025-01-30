from google.cloud import bigquery
import os
from dotenv import load_dotenv, find_dotenv
import psycopg2
import time

# Number of table rows to be uploaded to postgreSQL. For all rows please set this value to 0
num_of_rows = 100000

# in order to create a safety layer for db password, we can use the lib dotenv and save password in .env file
# to retrieve it we use this lib's methods and os
load_dotenv(find_dotenv())

# postgreSQL variables
pg_host = os.environ.get('POSTGRES_HOST')
pg_dbName = os.environ.get('POSTGRES_DB')
pg_user = os.environ.get('POSTGRES_USER')
pg_password = os.environ.get('POSTGRES_PASSWORD')

# BigQuery variables
bq_key_file = os.environ.get('BQ_KEYFILE')
bq_project_id = os.environ.get('BQ_PROJECTID')
bq_dataset_id = os.environ.get('BQ_DATASETID')
bq_table_id = os.environ.get('BQ_TABLEID')

# Provide a custom SQL query
if num_of_rows <= 0:
    bq_query = f"""
    SELECT *
    FROM `{bq_project_id}.{bq_dataset_id}.{bq_table_id}`
    """
else:
    bq_query = f"""
    SELECT *
    FROM `{bq_project_id}.{bq_dataset_id}.{bq_table_id}` LIMIT {num_of_rows}
    """


def bigquery_to_postgresql(pg_host, pg_dbName, pg_user, pg_password, bq_project_id, query=None):
    """
    Fetches data from a BigQuery table and loads it to postgreSQL.
    """

    print('\n---Connecting to BigQuery ---\n')
    # Set the path to your service account key file
    global_start_time = time.perf_counter()
    rootdir = os.path.dirname(os.path.abspath(__file__))
    keyPath = os.path.join(rootdir, "key", bq_key_file)
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = keyPath

    # Initialize a BigQuery client, run the query and fetch results
    client = bigquery.Client(project=bq_project_id)
    query_job = client.query(query)

    print('  - retrieving iowa_liquor_sale data from BQ...')
    results = query_job.result()

    # Convert results to a list of dictionaries
    rows = [dict(row) for row in results]

    print('  - data has been retrieved -')

    print('\n--- Connecting to postgreSQL ---\n')
    # Connecting to postgreSQL
    conn = psycopg2.connect(
        host = pg_host, 
        dbname = pg_dbName, 
        user = pg_user, 
        password = pg_password)
    cur = conn.cursor()

    print('  - truncating table in PG...')
    cur.execute("TRUNCATE yalo_raw.iowa_liquor_sale")
    conn.commit()
    print('  - table truncated -\n')


    print('  - uploading data to PG...')
    # Insert each row into the postgreSQL yalo_raw.iowa_liquor_sale table
    for i in range(len(rows)): 
        start_time = time.perf_counter()
        cur.execute("INSERT INTO yalo_raw.iowa_liquor_sale ( \
                    invoice_and_item_number, \
                    date, \
                    store_number, \
                    store_name, \
                    address, \
                    city, \
                    zip_code, \
                    store_location, \
                    county_number, \
                    county, \
                    category, \
                    category_name, \
                    vendor_number, \
                    vendor_name, \
                    item_number, \
                    item_description, \
                    pack, \
                    bottle_volume_ml, \
                    state_bottle_cost, \
                    state_bottle_retail, \
                    bottles_sold, \
                    sale_dollars, \
                    volume_sold_liters, \
                    volume_sold_gallons\
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", tuple(rows[i].values()))
        conn.commit()
        
        if i != 0:
            if i % 10000 == 0:
                end_time = time.perf_counter()
                total_time = end_time - start_time
                print(f'{int(10000 * (i/10000))} lines uploaded in {(total_time * 10000):.4f} seconds')
        

    cur.close()
    conn.close()
    global_end_time = time.perf_counter()
    global_time = global_end_time - global_start_time
    print(f'--- Data ingested successfully in approx. {int(global_time/60)} minutes ---')


if __name__ == "__main__":
    bigquery_to_postgresql(pg_host, pg_dbName, pg_user, pg_password, bq_project_id, query=bq_query)