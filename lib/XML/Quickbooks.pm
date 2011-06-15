package XML::Quickbooks;
# ABSTRACT: XML::Toolkit classes for manipulating Quickbooks

use Moose;

has 'request' => (is => 'rw');
has 'response' => (is => 'rw');
has 'responsetree' => (is => 'rw', lazy_build => 1);
has 'responseerror' => (is => 'rw');

use Carp;

sub _build_responsetree {
     my($self)=@_;

     use XML::TreeBuilder;
     my $tree = XML::TreeBuilder->new;
     $tree->parse($self->response);
     $tree;
}


sub responseok {
     my($self)=@_;

     my $s = 'statusMessage';
     #warn $self->responsetree;
     my $elem = $self->responsetree->look_down($s => qr/.+/);
     #warn $elem->as_HTML;
     my $status = $elem->attr($s);
     if ($status eq 'Status OK') {
	  1;
     } else {
	  $self->responseerror($status);
	  Carp::cluck($status);
	  0;
     }
	  
}


=head1 SYNOPSIS

    ...

=method method_x

This method does something experimental.

=method method_y

This method returns a reason.

=head1 SEE ALSO

=for :list
* L<OSR|https://member.developer.intuit.com/qbSDK-current/Common/newOSR/index.html>
* L<SDK Reference|https://member.developer.intuit.com/qbSDK-Current/doc/html/wwhelp/wwhimpl/js/html/wwhelp.htm?context=QBSDKProGuide&topic=QBSDKProGuide2>
* L<SDK Index|https://ipp.developer.intuit.com/0085_QuickBooks_Windows_SDK/010_qb/0050_Documentation/Manuals>
* L<Intuit Forums|https://idnforums.intuit.com/categories.aspx?catid=7>

=cut
1;
