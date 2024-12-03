import duckdb
con = duckdb.connect(database=':memory:', read_only=False)
query = con.execute("select * from read_csv('data/movie_metadata.csv');").fetch_arrow_table()
df = query.to_pandas()
print(df.head())
