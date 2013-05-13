#!/usr/bin/perl

use strict;
use warnings;
use isbn2ppn;
#use LWP::Simple;	# get(url)

# Attention à ne pas mettre de retour à la ligne Windows dans le fichier ISBN : uniquement UNIX


=head1 NAME
recouvrement.pl
=cut

=head1 DESCRIPTION
A partir d'une liste d'ISBN, permet de connaître ceux qui ont une notice dans le Sudoc et évaluer ainsi la quantité d'ouvrages à cataloguer.

romain.vanel@ujf-grenoble.fr
rugbis@ujf-grenoble.fr

=cut

=head1 UTILISATION

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


=cut

=head1 LICENCE

GNU/GPL

=cut

#------------------------------------------------------------------------------
# Paramêtres généraux


#==============================================================================
# main

my $fichier_de_base = "isbn" ;
my $cpt_total  = '0';
my $cpt_trouve  = '0';
my $cpt_non_trouve  = '0';


open(FICHIER_DE_BASE, $fichier_de_base) ||
  die "ficher $fichier_de_base introuvable : $!";
  
my @fichier_de_base = <FICHIER_DE_BASE>;
close FICHIER_DE_BASE ;


foreach my $ligne_fichier_de_base (@fichier_de_base) {
  $cpt_total  += 1;
  my $isbn_a_chercher = $ligne_fichier_de_base;
  chomp ($isbn_a_chercher);
  
  my @ppn = isbn2ppn::isb2pp($isbn_a_chercher);
  our $i123 = $isbn_a_chercher;

  if (@ppn) {
  	$cpt_trouve  += 1;
  	print "@ppn est le PPN de $i123\n\n";
	open(LISTE, ">>liste_ppn_isbn.log") || die "Erreur E/S:$!\n";
	print LISTE "@ppn ; $i123\n\n";
	close LISTE;
  }
  else {
  	$cpt_non_trouve  += 1;
  	print "NON trouvé pour $i123\n";
  }

}

open(LOG, ">>rapport.log") || die "Erreur E/S:$!\n";
print "Total ISBN cherchés = $cpt_total\n";
print LOG "Total ISBN cherchés = $cpt_total\n";
print "ISBN trouvés = $cpt_trouve\n";
print LOG "ISBN trouvés = $cpt_trouve\n";
print "ISBN non trouvés = $cpt_non_trouve\n";
print LOG "ISBN non trouvés = $cpt_non_trouve\n";
close LOG;
