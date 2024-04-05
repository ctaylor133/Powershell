
#!/usr/bin/perl
use strict;

my $MYSQL_HOST = `grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' /opt/onelink/etc/database.properties | awk 'NR==1{print}'`;
chomp($MYSQL_HOST);  # Remove trailing newline character

use DBI;
my $dbh = DBI->connect("DBI:mysql:onelink;host=$MYSQL_HOST", 'onelink', 'fixme', { RaiseError => 1 }
) || die "Could not connect to database: $DBI::errstr";

my $sql = "SELECT AssetNumber, Location, COUNT(*) AS DuplicateAssetCount FROM Device WHERE DeviceType = 'ICard' AND InactiveDate IS NULL AND ReplacedDate IS NULL AND EndDate IS NULL GROUP BY AssetNumber HAVING COUNT(*) >= 2";

print "Duplicate Device Check\n";
print "======================\n";
my $cnt = 0;
my $sth = $dbh->prepare($sql);
$sth->execute();
while (my $result = $sth->fetchrow_hashref()) {
    print "Asset: $result->{AssetNumber} Location: $result->{Location} DupeCount: $result->{DuplicateAssetCount}\n";
    $cnt++;
}

$sth->finish();

$dbh->disconnect();

if ($cnt == 0) {
    print "No duplicate devices found\n";
    exit(2);
}

exit(1);
