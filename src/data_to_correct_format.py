"""Hello"""
from string_to_bytes32 import string_to_bytes32
import pandas as pd


def main():
    """Hello"""
    df = pd.read_csv('../data/bison_data.csv')

    bison_list = [row['bison'] for _, row in df.iterrows()]
    byteson_list = [string_to_bytes32(bison) for bison in bison_list]
    max_dist_list = [row['travel_distance'] for _, row in df.iterrows()]

    print(str(byteson_list).replace('\'', '"') + ',' + str(max_dist_list))


if __name__ == '__main__':
    main()
