# Topology-Control-WSN
This dataset contains log results of simulation results used to generate the figures included in the manuscript titled:  "Centrality-based Topology Control in Routing Protocols for Wireless Sensor Networks with Community Structure"  

README – Full Simulation Dataset
This repository contains the complete dataset of simulation results generated for the research article:

"Centrality-based Topology Control in Routing Protocols for Wireless Sensor Networks with Community Structure"

1. Purpose of the Dataset
This dataset was produced through extensive simulations using the ns-3 network simulator and is intended to support the validation, replication, and extension of the results presented in the manuscript. The simulations focus on evaluating the performance of a community-aware topology control mechanism integrated into the Hybrid Wireless Mesh Protocol (HWMP) under various mobility and traffic scenarios.

2. Source of Data
All simulation data were generated with ns-3, using the Map-Based Mobility Model to emulate realistic node movement patterns. The simulations were executed under controlled parameters, and the outputs were exported from ns-3 trace files and logs.

3. Content Description
The dataset includes results for multiple configurations and traffic flows. Each data file contains the following metrics:

Number of routed messages

Number of forwarded messages

Total number of packets sent

Total number of packets received

Transmission energy consumption (in bytes)

Reception energy consumption (in bytes)

Routing delay values (per flow or aggregate)

Node identifiers and roles (where applicable)

Simulation timestamps and flow labels

The data are organized by mobility scenario and experimental configuration (e.g., with and without community structure, different node densities, traffic rates, etc.).


4. Tools and Processing
The data were processed and exported using custom scripts developed in Python and Bash for post-processing ns-3 output logs. No additional transformations were applied beyond formatting and metric aggregation.

5. License and Use Terms
This dataset is distributed for academic and research purposes only. If used in any derivative works, publications, or comparative studies, please cite the original article and acknowledge the authors. The data remain the intellectual property of the research group at Universidad de Cuenca.

6. Requesting Support or Additional Information
For questions regarding the dataset structure, simulation parameters, or to request additional data not included in this repository, please contact the corresponding author of the article.
