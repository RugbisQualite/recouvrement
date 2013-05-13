package isbn2ppn;
use strict;
use warnings;
use LWP::Simple;	# get(url)

=head1 NAME
isbn2ppn.pm
=cut

=head1 DESCRIPTION
A partir d'un ISBN, cherche et renvoie (le cas échéant) le PPN de la notice trouvée.

romain.vanel@ujf-grenoble.fr
rugbis@ujf-grenoble.fr

=cut

=head1 UTILISATION

Nécessite les packages :  LWP::Simple.pm

Accepte en entrée un ISBN.

Renvoie 0 ou une liste de PPN.


=cut

=head1 LICENCE

GNU/GPL

=cut


my $url_abes = "http://www.sudoc.fr/services/isbn2ppn/";


sub isb2pp {
my ($isbn_a_chercher) = @_ ;
my $isb = $isbn_a_chercher;
my $url_creee = $url_abes . $isb;
my $page_isbn = &downloader_de_page($url_creee);
  if ($page_isbn) {
     my @ppn_trouve = chercheur_isbn($page_isbn);
    chomp @ppn_trouve;
    return @ppn_trouve
  }
  else {
  	return ;
  }
;
}

#------------------------------------------------------------------------------
sub downloader_de_page {
  my ($url) = @_ ;
  if (my $page = get($url)) {
  	 return $page;
	}
    else {
      return 0;
    };
} 

#------------------------------------------------------------------------------
sub chercheur_isbn {
  my ($page) = @_ ;
    $page =~ s/<\/ppn>/\n</g;
    $page =~ s/.*ppn>//g;
    $page =~ s/<.*\n|.*>//g;
  my @tout = $page;
return @tout;
}

1;