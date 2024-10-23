set USINES; #ensemble des usines
set DEPOTS; #ensemble des depots
set CLIENTS; #ensemble des clients

set ROUTES dimen 2; #ensemble des routes possibles, 2 dimensions
set ROUTES_NON_SOUHAITEES dimen 2; #q3 pour satisfaire les clients
set ROUTES_q3 := ROUTES diff ROUTES_NON_SOUHAITEES; #q3

param couts{ROUTES} >= 0; #les couts des differentes routes possibles
param cap_usi{USINES} >= 0; #quantite maximale pouvant etre envoyee par chaque usine
param cap_dep{DEPOTS} >= 0; #quantite maximale pouvant etre recue pour chaque depot
param besoin{CLIENTS} >= 0; #besoins des clients

#question 4
param cap_depart{DEPOTS} >= 0; #capacite initiale des depots avant tout changement
param cap_chgmt{DEPOTS}; #capacite apres changement
param cout_chgmt{DEPOTS}; #cout du changement

var tonnes{ROUTES} >= 0; #les tonnes a envoyer depuis les usines/depots
#var statut_dep{DEPOTS} binary; #q4, 0 si pas de chgmt, 1 sinon

#pour les questions 1/2
#minimize cout_total : #fonction a minimiser
#	sum{(i,j) in ROUTES} couts[i,j] * tonnes[i,j];

#subject to contrainte_cap_usines {i in USINES}:	#quantite maximale pouvant etre envoyee depuis les usines
#	sum{(i,j) in ROUTES} tonnes[i,j] <= cap_usi[i];

#subject to contrainte_cap_depots {i in DEPOTS}: #quantite maximale pouvant etre recue par les depots depuis les usines
#	sum{(j,i) in ROUTES : j in USINES} tonnes[j,i] <= cap_dep[i];

#subject to contrainte_besoins {j in CLIENTS}: #quantite demandee par les clients
#	 sum{(i,j) in ROUTES} tonnes[i,j] = besoin[j];

#subject to contrainte_stock_depots {i in DEPOTS}: 
#	sum{(j,i) in ROUTES : j in USINES} tonnes[j,i] >= sum{(i,k) in ROUTES : k in CLIENTS} tonnes[i,k];
#les depots ne peuvent pas envoyer plus que ce qu'ils recoivent depuis les usines



#pour la question 3
minimize cout_total : #fonction a minimiser
	sum{(i,j) in ROUTES_q3} couts[i,j] * tonnes[i,j];

subject to contrainte_cap_usines {i in USINES}:	#quantite maximale pouvant etre envoyee depuis les usines_q3
	sum{(i,j) in ROUTES_q3} tonnes[i,j] <= cap_usi[i];

subject to contrainte_cap_depots {i in DEPOTS}: #quantite maximale pouvant etre recue par les depots depuis les usines
	sum{(j,i) in ROUTES_q3 : j in USINES} tonnes[j,i] <= cap_dep[i];

subject to contrainte_besoins {j in CLIENTS}: #quantite demandee par les clients /q3
	 sum{(i,j) in ROUTES_q3} tonnes[i,j] = besoin[j];

subject to contrainte_stock_depots {i in DEPOTS}: 
	sum{(j,i) in ROUTES_q3 : j in USINES} tonnes[j,i] >= sum{(i,k) in ROUTES_q3 : k in CLIENTS} tonnes[i,k];
#les depots ne peuvent pas envoyer plus que ce qu'ils recoivent depuis les usines

subject to contrainte_client5 : #satisfaire partiellement les preferences du client 5
	tonnes["Bir","C5"] = 50;



#pour la question 4
#minimize cout_total :
#	sum{(i,j) in ROUTES} couts[i,j]*tonnes[i,j] + sum{d in DEPOTS} cout_chgmt[d]*(statut_dep[d]); 

#subject to contrainte_cap_usines {i in USINES}:	#quantite maximale pouvant etre envoyee depuis les usines
#	sum{(i,j) in ROUTES} tonnes[i,j] <= cap_usi[i];

#subject to contrainte_cap_depots {i in DEPOTS}:
#	sum{(j,i) in ROUTES} tonnes[j,i] <= cap_depart[i] + (statut_dep[i])*cap_chgmt[i];

#subject to contrainte_besoins {j in CLIENTS}: #quantite demandee par les clients
#	 sum{(i,j) in ROUTES} tonnes[i,j] = besoin[j];

#subject to contrainte_stock_depots {i in DEPOTS}: 
#	sum{(j,i) in ROUTES : j in USINES} tonnes[j,i] >= sum{(i,k) in ROUTES : k in CLIENTS} tonnes[i,k];
#les depots ne peuvent pas envoyer plus que ce qu'ils recoivent depuis les usines

#subject to contrainte_depots_max : #pas plus de 4 depots
#	sum{i in DEPOTS} statut_dep[i] <= 4;
