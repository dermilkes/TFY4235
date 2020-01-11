import numpy as np
import matplotlib.pyplot as plt
import time

def main():
	step_max = 10000		# Number of maximal steps
	N = 10000				# Number of walks in simulation
	# M = np.zeros([N, step_max], dtype=np.int64)	#Empty array for data
	
	# rand = np.cumsum(np.random.uniform(-1, 1, (N, step_max)), axis = 1)
	M = np.cumsum(np.random.choice([-1,1], (N, step_max)), axis = 1)
	
	# print(M)
	"""
	# Create random data
	for i in range(N):
		last = 0
		for j in range(step_max):
			last += np.random.choice([-1, 1])
			M[i][j] = last
	
	# print(M)
	"""
	
	# Find first zero of each walk
	data = np.zeros(step_max)
	for i in range(N):
		j = 0
		found = False
		while (not found) and (j != step_max):
			if M[i][j] == 0:
				data[j] += 1
				found = True
			j += 1
		
	print(data)
	
	
	return 0

main()

