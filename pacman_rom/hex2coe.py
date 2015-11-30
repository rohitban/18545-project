import sys

radix = """MEMORY_INITIALIZATION_RADIX=16;\nMEMORY_INITIALIZATION_VECTOR="""

readCount = 5
byteSlice = 2

def createColorCoe(filename):
	value_string = ""
	for line in open(filename):
		line = line.rstrip("\n")
		for word in line.split(" "):
			firstByte = word[:byteSlice]
			secondByte = word[byteSlice:]

			value_string += "\n" + firstByte +","
			value_string += "\n" + secondByte + ","

	return value_string

def createPaletteCoe(filename):
	value_string = ""
	span = 2
	for line in open(filename):
		line = line.rstrip("\n")
		chunk16 = line.split(" ")
		chunk4byte = [" ".join(chunk16[i:i+span]) for i in range(0, len(chunk16), span)]

		for entry in chunk4byte:
			entry = entry.replace(" ","")
			
			value_string += "\n" + entry + ","

	return value_string

def createTileCoe(filename):
	value_string = ""
	for line in open(filename):
		line = line.rstrip("\n")
		line = line.replace(" ","")
		
		line = hex(int(line))[2:]

		value_string += "\n" + line + ","

	return value_string

def createSpriteCoe(filename):
	value_string = ""
	count  = 0
	with open(filename) as fileObj:
		while True:
			lineList = []
			line1 = fileObj.readline()
			if not line1: break
			lineList.append(line1.rstrip("\n"))

			for i in xrange(3):
				line = fileObj.readline()
				lineList.append(line.rstrip("\n"))

			assert(len(lineList)==4)

			add_string = ""
			for j in xrange(len(lineList)):
				line = lineList[j]
				line = line.replace(" ","")

				add_string += line

			value_string += "\n" + add_string + ","
			count += 1

	return value_string

#program to read rom files and generate a
#byte addressable .coe file
def main():

	cmd_args = sys.argv
	total_args = len(cmd_args)

	if(total_args < 1):
		print("Pass a valid filename as an arg!!")
		return
	
	#readType = cmd_args[2]
	readType = "16byte"		
	coe_string = radix
	#filename = cmd_args[1]
	filename = "text_roms/father.txt"
	
	try:
		#Colors are 8-bit values(1-byte)
		#Palettes are 32-bit values(4-byte)
		#Tiles are 16-bytes : (1 line, 64 bits)
		#Sprites are 64-bytes : (4 lines, 256 bits)

		if(readType=="1byte"):
			value_string = createColorCoe(filename)
		elif(readType=="4byte"):
			value_string = createPaletteCoe(filename)
		elif(readType=="16byte"):
			value_string = createTileCoe(filename)
		elif(readType=="64byte"):
			value_string = createSpriteCoe(filename)

	except:
		print("File open failure")

	coe_string += value_string
	coe_string = coe_string[:len(coe_string)-1] + ";"
	print(coe_string)

	

if __name__ == "__main__":
	main()
    
