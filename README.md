recouvrement
============

Permet des tests de recouvrement du Sudoc sur un fond de notices bibliographiques

A partir d'une liste d'ISBN, permet de connaître ceux qui ont une notice dans le Sudoc et évaluer ainsi la quantité d'ouvrages à cataloguer.

romain.vanel@ujf-grenoble.fr
rugbis@ujf-grenoble.fr


 UTILISATION

Nécessite les packages :  isbn2ppn.pm
Accepte en entrée un fichier CSV d'ISBN

Le nom du fichier doit être indiqué dans
my $fichier_de_base = "nom_du_fichier" ;

Liste des ISBN trouvés dans "liste_ppn_isbn.log" sous la forme
123456789 ; 978-2-221-12713-7

Rapport dans "rapport.log" sous la forme
Total ISBN cherchés = 4000
ISBN trouvés = 3300
ISBN non trouvés = 700



 LICENCE

GNU/GPL
