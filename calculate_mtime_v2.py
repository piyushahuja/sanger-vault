import base64
import csv
import time

input_file = "20210817_114.dat"
base_dir = "/lustre/scratch114/teams/hgi/users/"

max_mtime = 0
min_mtime = int(time.time())

with open(input_file, 'r') as mpi_data:
    reader = csv.reader(mpi_data, delimiter='\t')
    i = 0
    for row in reader:
        mtime = int(row[5])
        try:
            filepath = base64.b64decode(row[0]).decode()
        except UnicodeDecodeError as e:
            print(f"Unicode Decode Error in : {row}")
        else: 
            if filepath.startswith(base_dir):
                min_mtime = min(mtime, min_mtime)
                max_mtime = max(mtime, max_mtime)
        
print(f"max: {max_mtime} min: {min_mtime}")