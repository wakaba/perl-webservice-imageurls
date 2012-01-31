package test::WebService::ImageURLs;
use strict;
use warnings;
use Path::Class;
use lib file(__FILE__)->dir->parent->subdir('lib')->stringify;
use base qw(Test::Class);
use Test::More;
use WebService::ImageURLs;

sub _expand_image_permalink_url : Test(26) {
    for (
        [undef, undef],
        [0, undef],
        [q{http://foo/bar} => undef],
        [q{http://www.hatena.com/} => undef],
        [q{http://twitpic.com/1wh78q} => q{http://twitpic.com/show/thumb/1wh78q}],
        [q{http://twitpic.com/1wh78q"a} => undef],
        [q{http://plixi.com/p/61045991} => q{http://api.plixi.com/api/TPAPI.svc/imagefromurl?size=big&url=http://plixi.com/p/61045991}],
        [q{http://movapic.com/pic/201101070916204d265b5446847} => q{http://image.movapic.com/pic/s_201101070916204d265b5446847.jpeg}],
        [q{http://moby.to/cvra42} => q{http://moby.to/cvra42:full}],
        [q{http://yfrog.com/gzdsndj} => q{http://yfrog.com/gzdsndj.th.jpg}],
        [q{http://img.ly/2O0E} => q{http://img.ly/show/thumb/2O0E}],
        [q{http://twitgoo.com/yic7p} => q{http://twitgoo.com/yic7p/img}],
        [q{http://imgur.com/ChMlS} => q{http://i.imgur.com/ChMlS.jpg}],
        [q{http://ow.ly/i/Q8J} => q{http://static.ow.ly/photos/original/Q8J.jpg}],
        [q{http://bcphotoshare.com/photos/654908/2447480} => q{http://images.bcphotoshare.com/storages/2447480/large.jpg}],
        [q{http://pckles.com/karno/a40e0e} => q{http://pckles.com/karno/a40e0e.jpg}],
        [q{http://p.twipple.jp/RzArY} => q{http://p.twipple.jp/data/R/z/A/r/Y_m.jpg}],
        [q{http://twitvideo.jp/03HtN} => q{http://twitvideo.jp/img/display/03HtN}],
        [q{http://www.twitvid.com/3YAPM} => q{http://images.twitvid.com/3YAPM.jpg}],
        [q{http://www.frablo.jp/2010/12/18/cockatiel-chocobo-theme/} => q{http://www.frablo.jp/images/2010/12/18/cockatiel-chocobo-theme.png}],
        [q{http://copie.hatelabo.jp/cp/gYC-x53el_-UIQ} => q{http://copie.hatelabo.jp/cp/gYC-x53el_-UIQ.png}],
        [q{http://copie.hatelabo.jp/-gYC-x53el_-UIQ} => q{http://copie.hatelabo.jp/cp/gYC-x53el_-UIQ.png}],
        [q{http://photozou.jp/photo/show/381594/62305181} => q{http://art25.photozou.jp/bin/photo/62305181/org.bin?size=450}],
        [q{http://pikchur.com/3Rw} => q{http://img.pikchur.com/pic_3Rw_l.jpg}],
        [q{http://picplz.com/afawf} => q{http://picplz.com/afawf/thumb/400}],
        [q{http://instagr.am/p/xTP8/} => q{http://instagr.am/p/xTP8/media}],
    ) {
        is expand_image_permalink_url $_->[0], $_->[1];
    }
}

__PACKAGE__->runtests;

1;
