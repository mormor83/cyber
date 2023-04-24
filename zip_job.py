import string
from zipfile import ZipFile
import logging

# get the root logger
logger = logging.getLogger()
# create a formatter object
logFormatter = logging.Formatter("%(asctime)s -  %(levelname)s - %(message)s", datefmt="%Y-%m-%d %H:%M:%S")

# add console handler to the root logger
consoleHandler = logging.StreamHandler()
consoleHandler.setFormatter(logFormatter)
logger.addHandler(consoleHandler)
logger.setLevel(logging.DEBUG)

VERSION = "1.2.0"

# Create an array of a-z
alphabet = []
for l in string.ascii_lowercase:
    alphabet.append(l)
logger.info("Created an array 'alphabet' with letters from a-z ")

# create dedicate files based on the array
for letter in alphabet:
    try:
        f = open(f"{letter}.txt", "x")
        f.close()
    except FileNotFoundError:
        logger.warning(f"The file {letter}.txt does not exist")
    except FileExistsError:
        logger.warning(f"The file {letter}.txt exists")

# create zip files
for letter in alphabet:
    try:
        zipObj = ZipFile(f"{letter}_{VERSION}.zip", 'x')
        zipObj.write(f'{letter}.txt')
        zipObj.close()
    except FileExistsError:
        logger.warning(f"The file {letter}_{VERSION}.zip exists")
