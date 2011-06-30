package XML::Quickbooks::Util;
# ABSTRACT: various utility functions

use Moose::Role;

sub lnew {
  my($self, $pkgtail, @constructor_args)=@_;

  use Class::MOP;
  my $class = "XML::Quickbooks::Tolol::$pkgtail";
  Class::MOP::load_class($class);
  $class->new(@constructor_args);
}

sub tknew {
  my($self, $pkgtail, @constructor_args)=@_;

  use Class::MOP;
  my $class = "XML::Quickbooks::Tk::$pkgtail";
  Class::MOP::load_class($class);
  $class->new(@constructor_args);
}

sub tbnew {
  my($self, $pkgtail, @constructor_args)=@_;

  use Class::MOP;
  my $class = "XML::Quickbooks::Tk::$pkgtail";
  Class::MOP::load_class($class);
  $class->new(@constructor_args);
}


sub trunc {
  my($self, $length, $string)=@_;

  substr($string, 0, $length);

}

sub hashrender {
  my($self, $key, $hash)=@_;
  return '' unless my $v = $hash->{$key} // undef;

  my $X = XML::Generator->new(pretty    => 2);
  $X->$key($v);
}

1;
