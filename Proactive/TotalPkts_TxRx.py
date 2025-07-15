#Extrae el numero total de paquetes Rx con exito
#del monitor de flujo

import re
from numpy import *

snap = [1,2,3,4,5]
num_Runs = 50
num_sim = 7
num_Root =  [ 1, 2, 2, 3, 3]
num_flows = [25,25,50,25,75]
type_sim = 'ControlRVaz' 		#AllRouters - SpanningTree - ControlRouters - ControlRVaz para la carpeta de salida
typeOutDir = 'Out_Proac_ControlRVaz'	#Out_Proac_AllR - Out_Proac_SpanTree - Out_Proac_ControlR - Out_Proac_ControlRVaz carpteta contenedora semejante a type_sim
raiz_ns ='/Users/juandi/Documents' 


for snp in range(0, len(snap)):

	for flow in range(0,len(num_flows)):

		totalTxPkts = [0 for i in range(1,num_Runs+1)]
		totalRxPkts = [0 for i in range(1,num_Runs+1)]
		totalLostPkts = [0 for i in range(1,num_Runs+1)]
		delay = []
		delay2 = [0 for i in range(1,num_Runs+1)]
		
		s="\n Snap: "+str(snap[snp])+"\tRoots:"+str(num_Root[flow])+"\tFlows: "+str(num_flows[flow]) +"\n"
		s+="TotalTxPkts\tTotalRxPkts\tTotalLostPkts\n"

		for r in range(0,num_Runs):

			in_f = raiz_ns+'/Tesis/'+typeOutDir+'/Sim0'+str(num_sim)+'/Snap_'+str(snap[snp])+'/Flow_Mon/R'+str(num_Root[flow])+'F'+str(num_flows[flow])+'T5120000_Run'+str(r+1)+'.xml'
			input_file = open(in_f,'r')
			
			
			while True:
				line = input_file.readline()
				if not line: break
				# if ('delaySum=' in line):
					# data2 = line.split(' ') 
					# d_s= data2[10].split('"')
					# delay_sum = d_s[1]
					# delay.append(float(delay_sum[:-2])*1e-9)
				
				if ('timeFirstTxPacket=' in line):
					data = line.split(' ')
					txPkts = data[15].split('"')
					rxPkts = data[16].split('"')
					lostPkts = data[17].split('"')
					totalTxPkts[r] = totalTxPkts[r]+int(txPkts[1])
					totalRxPkts[r] = totalRxPkts[r]+int(rxPkts[1])
					totalLostPkts[r] = totalLostPkts[r]+int(lostPkts[1])			
					
			#s+=str(totalTxPkts[r])+"\t\t"+str(totalRxPkts[r])+"\t\t"+str(totalLostPkts[r])+"\n"

			 
		print(s)
		input_file.close()

		out_f1 = type_sim + '/Sim0'+str(num_sim)+'/TotalPkts_TxRx/Rx_S'+str(snap[snp])+'R'+str(num_Root[flow])+'F'+str(num_flows[flow])+'.dat'
		output_file1 = open(out_f1,'w')
		savetxt(output_file1, totalRxPkts)
		#output_file1.write(str(totalRxPkts))
		output_file1.close()
		
		# out_f2 = type_sim + '/Sim0'+str(num_sim)+'/TotalPkts_TxRx/Tx_Snap'+str(snap[snp])+'Flow'+str(num_flows[flow])+'.txt'
		# output_file2 = open(out_f2,'w')
		# output_file2.write(str(totalTxPkts))
		# output_file2.close()  
