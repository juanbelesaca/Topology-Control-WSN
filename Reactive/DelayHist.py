# Filtro para sacar el histograma total del Delay de flujos UDP 
# La salida es un vector que contiene el uno de ocurrencias para cada indice q representa el delay
# el momento de ejecutar se puede guardar DelayFlowX.txt para copiar directamente el vector en Matlab
# y ahi hacer las graficas y estadisticas requeridas (usando dfittool)  

from __future__ import division
import sys
import os
import re
import xml.etree.ElementTree as ET
from numpy import *

snap = [1,2,5]
num_nodes = 100
num_Runs = 50
num_sim = 3
num_flows =[10,15,20,25,30,35,40]
type_sim = 'ControlRouters' 		#AllRouters - SpanningTree - ControlRouters - ControlRVaz para la carpeta de salida
typeOutDir = 'Out_Reac_ControlR'	#Out_Reac_AllR - Out_Reac_SpanTree - Out_Reac_ControlR - Out_Reac_ControlRVaz carpteta contenedora semejante a type_sim
raiz_ns ='/Users/juandi/Documents' 


#s="Index \n"

for flow in range(0,len(num_flows)):

	count=[0 for i in range(0,11000)]
	
	for snp in range(0,len(snap)):

		for run in range(0,num_Runs):

			tree = ET.parse(raiz_ns+'/Tesis/'+typeOutDir+'/Sim0'+str(num_sim)+'/Snap_'+str(snap[snp])+'/Flow_Mon/Flows'+str(num_flows[flow])+'_Run'+str(run+1)+'.xml')
			root = tree.getroot()
			print (run)
			for i in range(0,num_flows[flow]):
				for child in root[0][i][0]:
					index=int(child.get('index'))
					count[index]=count[index]+int(child.get('count'))
					
	out_f1 = type_sim + '/Sim0'+str(num_sim)+'/Delay/HistDelay_Flow'+str(num_flows[flow])+'.dat'
	output_file1 = open(out_f1,'w')
	savetxt(output_file1, count)
	#output_file1.write(count)
	output_file1.close()  
	print('Saved Flow: '+str(num_flows[flow])+'\n') 

#print(count)


