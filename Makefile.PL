use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'ZipApp',
    AUTHOR              => q{Takeshi OKURA<okura3@gmail.com>},
    VERSION_FROM        => 'lib/ZipApp.pm',
    ABSTRACT            => 'Retrive Japan Postal Code',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'YAML'       => 0,
        'Dancer'     => 1.3070,
        'Plack'      => 0.9980,
        'URI::Escape' => 3.30,
        'Dancer::Plugin::DBIC' => 0.1504,
        'DBD::SQLite' => 1.33,
        'DBI' => 1.616,
        'Text::Xslate' => 1.3001,
        'Dancer::Template::Xslate' => 0.01,
        'Net::Twitter::Lite' => 0.10004,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'ZipApp-*' },
);
