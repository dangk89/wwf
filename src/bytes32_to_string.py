"""Convert a string of hex bytes32 to a string"""
import sys


def bytes32_to_string(bytes32):
    """Convert a string of hex bytes32 to a string"""
    return int(bytes32, 16).to_bytes(32, 'big').decode('utf8').strip('\x00')


def main():
    print(bytes32_to_string(sys.argv[1]))


if __name__ == '__main__':
    main()
