#Este scrip extraee los bytes transmitidos y recividos por 
#cada nodo, obtenido del mesh report.
#en horizontal los valores de Bytes por Run
#en vertical los 50 nodos

import re
from numpy import *

snap = [1,2,3,4,5]
num_nodes = 100
num_Runs = 50
num_sim = 7
num_Root =  [ 1, 2, 2, 3, 3]
num_flows = [25,25,50,25,75]
type_sim = 'ControlRVaz' 		#AllRouters - SpanningTree - ControlRouters - ControlRVaz para la carpeta de salida
typeOutDir = 'Out_Proac_ControlRVaz'	#Out_Proac_AllR - Out_Proac_SpanTree - Out_Proac_ControlR - Out_Proac_ControlRVaz carpteta contenedora semejante a type_sim
raiz_ns ='/Users/juandi/Documents' 

for snp in range(0,len(snap)):
	
	for flow in range(0,len(num_flows)):
		
		rxBytes = zeros((num_nodes,num_Runs))
		txBytes = zeros((num_nodes,num_Runs))
		aux = zeros((num_nodes,num_Runs))

		sout="\n"
		s="\n Snap:"+str(snap[snp])+"\tRoots:"+str(num_Root[flow])+"\tFlows: "+str(num_flows[flow]) +"\n"
		s+="|txBytes|/|rxBytes| "
		print(s)


		for run in range(0,num_Runs):

			for nodeID in range(0,num_nodes):
				aux[nodeID,run]=0

				in_f = raiz_ns+'/Tesis/'+typeOutDir+'/Sim0'+str(num_sim)+'/Snap_'+str(snap[snp])+'/Mesh_Reports/R'+str(num_Root[flow])+'F'+str(num_flows[flow])+'T5120000/Run'+str(run+1)+'/Node'+str(nodeID)+'.xml'
				input_file = open(in_f,'r')
			
				while True:
					line = input_file.readline()
					if not line: break
				
					if ('rxBytes="' in line):
						data1 = line.split('"')
						rxBytes[nodeID,run] = int(data1[9])

					
					if ('txBytes="' in line):
						if (aux[nodeID,run]==0):
							data3 = line.split('"')
							txBytes[nodeID,run] = int(data3[5])
							aux[nodeID,run]+=1
						 

			#valoresTotales de suma
			#sout+=str(txBytes)+"\n"
			#sout+=str(rxBytes)+"\n"
			
			  
		print(sout)  
		input_file.close()

		out_f1 = type_sim + '/Sim0'+str(num_sim)+'/Energ_BytesTxRx/Tx_S'+str(snap[snp])+'R'+str(num_Root[flow])+'F'+str(num_flows[flow])+'.dat'
		output_file1 = open(out_f1,'w')
		savetxt(output_file1, txBytes,delimiter=",")
		#output_file1.write(str(txMgt_Rout))
		output_file1.close()    
			
		out_f2 = type_sim + '/Sim0'+str(num_sim)+'/Energ_BytesTxRx/Rx_S'+str(snap[snp])+'R'+str(num_Root[flow])+'F'+str(num_flows[flow])+'.dat'
		output_file2 = open(out_f2,'w')
		savetxt(output_file2, rxBytes,delimiter=",")
		#output_file2.write(str(fwdUnicast))
		output_file2.close()



 
