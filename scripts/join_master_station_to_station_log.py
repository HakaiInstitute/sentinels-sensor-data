"""Convert Master_Stations.csv to station-log.csv format.

Master_Stations.csv is synced via a github action from the
https://github.com/HakaiInstitute/sentinels-light-trap/blob/main/data/Master_Stations.csv
repository. This script is used to convert the
Master_Stations.csv to the station-log.csv
"""
import pandas as pd


station_log_columns = [
    "station",
    "station_code",
    "organization",
    "latitude",
    "longitude",
    "deployment",
    "commissioned_time",
    "decomissioned_time",
    "fixed_depth",
    "comments",
]



def join_master_station_to_station_log():
    df_master = pd.read_csv("Master_Stations.csv")
    df_station_log = pd.read_csv("station-log.csv", index_col="station_name")

    df_master.rename(
        columns={
            "Site": "station_name",
            "Lat": "latitude",
            "Lon": "longitude",
            "Code": "station_code",
            "Comment": "comments",
            "Organization": "organization",
        },
        inplace=True,
    )
    df_master.columns = df_master.columns.str.lower()
    df_master.set_index("station_name", inplace=True)
    # Add station_name rows that are not in the station-log.csv
    df_joined = df_master.combine_first(df_station_log).sort_index()
    # sort columns
    df_joined = df_joined[station_log_columns + [col for col in df_joined.columns if col not in station_log_columns or col == "station_name"]]

    # fill unassiasgned station  with station_name
    df_joined["station"] = df_joined["station"].fillna(df_joined.index.to_series().str.replace(" ", "_").str.lower())
    df_joined.to_csv("station-log.csv", index=True)


if __name__ == "__main__":
    join_master_station_to_station_log()
