package WebService::ImageURLs;
use strict;
use warnings;
our $VERSION = '2.0';
use Carp;

our @EXPORT = qw(expand_image_permalink_url);

sub import ($;@) {
  my $from_class = shift;
  my ($to_class, $file, $line) = caller;
  no strict 'refs';
  for (@_ ? @_ : @{$from_class . '::EXPORT'}) {
    my $code = $from_class->can ($_)
        or croak qq{"$_" is not exported by the $from_class module at $file line $line};
    *{$to_class . '::' . $_} = $code;
  }
} # import

sub expand_image_permalink_url ($) {
    my $url = shift or return undef;
    
    if ($url =~ m<^http://twitpic\.com/([0-9A-Za-z]+)$>) {
        # Document: <http://dev.twitpic.com/docs/thumbnails/>.
        # Example: <http://twitpic.com/1wh78q> ->
        # <http://twitpic.com/show/thumb/1wh78q>.
        return q<http://twitpic.com/show/thumb/> . $1;
    } elsif ($url =~ m<^http://plixi\.com/p/[0-9]+$>) {
        # Document:
        # <http://groups.google.com/group/tweetphoto/web/fetch-image-from-tweetphoto-url>.
        return q<http://api.plixi.com/api/TPAPI.svc/imagefromurl?size=big&url=> . $url;
    } elsif ($url =~ m<^http://movapic\.com/pic/([0-9A-Za-z]+)$>) {
        return q<http://image.movapic.com/pic/s_>.$1.q<.jpeg>;
    } elsif ($url =~ m<^http://moby\.to/[0-9A-Za-z]+$>) {
        # Document:
        # <http://developers.mobypicture.com/documentation/additional/inline-thumbnails/>.
        return $url . q<:full>;
    } elsif ($url =~ m<^http://yfrog\.com/[0-9A-Za-z]+$>) {
        # Document: <http://code.google.com/p/imageshackapi/wiki/YFROGurls>.
        return $url . q<.th.jpg>;
    } elsif ($url =~ m<^http://img\.ly/([0-9A-Za-z]+)$>) {
        return q<http://img.ly/show/thumb/> . $1;
    } elsif ($url =~ m<^http://twitgoo\.com/[0-9A-Za-z]+$>) {
        return $url . q</img>;
    } elsif ($url =~ m<^http://instagr.am/p/([0-9A-Za-z]+)/$>) {
        # Document: <http://instagram.com/developer/embedding/#media>.
        return qq<http://instagr.am/p/$1/media>;
    } elsif ($url =~ m<^http://imgur\.com/([0-9A-Za-z]+)$>) {
        return q<http://i.imgur.com/> . $1 . q<.jpg>;
    } elsif ($url =~ m<^http://ow\.ly/i/([0-9A-Za-z]+)$>) {
        return q<http://static.ow.ly/photos/original/> . $1 . q<.jpg>;
    } elsif ($url =~ m<^http://bcphotoshare\.com/photos/[0-9]+/([0-9]+)$>) {
        return q<http://images.bcphotoshare.com/storages/> . $1 . q</large.jpg>;
    } elsif ($url =~ m<^http://pckles\.com/[0-9A-Za-z]+/[0-9A-Za-z]+$>) {
        return $url . '.jpg';
    } elsif ($url =~ m<^http://p\.twipple\.jp/([0-9A-Za-z])([0-9A-Za-z])([0-9A-Za-z])([0-9A-Za-z])([0-9A-Za-z])$>) {
        return qq<http://p.twipple.jp/data/$1/$2/$3/$4/$5_m.jpg>;
    } elsif ($url =~ m<^http://twitvideo\.jp/([0-9A-Za-z]+)$>) {
        return qq<http://twitvideo.jp/img/display/$1>;
    } elsif ($url =~ m<^http://www\.twitvid\.com/([0-9A-Za-z]+)$>) {
        return qq<http://images.twitvid.com/$1.jpg>;
    } elsif ($url =~ m<^http://www.frablo.jp/([0-9]+/[0-9]+/[0-9]+/[0-9A-Za-z_-]+)/$>) {
        return qq<http://www.frablo.jp/images/$1.png>;
    } elsif ($url =~ m{^http://copie\.hatelabo\.jp/(?:cp/|-)gYC-([0-9A-Za-z_-]+)$}) {
        return qq<http://copie.hatelabo.jp/cp/gYC-$1.png>;
    } elsif ($url =~ m{^http://photozou\.jp/photo/show/[0-9]+/([0-9]+)$}) {
        return qq<http://art25.photozou.jp/bin/photo/$1/org.bin?size=450>;
    } elsif ($url =~ m{^http://pikchur\.com/([0-9A-Za-z]+)$}) {
        return qq<http://img.pikchur.com/pic_$1_l.jpg>;
    } elsif ($url =~ m{^http://picplz.com/([0-9A-Za-z]+)$}) {
        return qq<http://picplz.com/$1/thumb/400>;
    } else {
        return undef;
    }
}

1;
