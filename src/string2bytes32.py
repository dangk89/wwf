"""Convert string to a string of hex bytes32"""
import sys


def string_to_bytes32(string):
    """Convert string to a string of hex bytes32"""
    bytes32 = ""
    for char in string:
        bytes32 += str(hex(ord(char))).strip('0x')
    return '0x' + bytes32


def main():
    print(string_to_bytes32(sys.argv[1]))


if __name__ == '__main__':
    main()
