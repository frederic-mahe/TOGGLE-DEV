
#!/usr/bin/env perl

###################################################################################################################################
#
# Copyright 2014-2017 IRD-CIRAD-INRA-ADNid
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/> or
# write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.
#
# You should have received a copy of the CeCILL-C license with this program.
#If not see <http://www.cecill.info/licences/Licence_CeCILL-C_V1-en.txt>
#
# Intellectual property belongs to IRD, CIRAD and South Green developpement plateform for all versions also for ADNid for v2 and v3 and INRA for v3
# Version 1 written by Cecile Monat, Ayite Kougbeadjo, Christine Tranchant, Cedric Farcy, Mawusse Agbessi, Maryline Summo, and Francois Sabot
# Version 2 written by Cecile Monat, Christine Tranchant, Cedric Farcy, Enrique Ortega-Abboud, Julie Orjuela-Bouniol, Sebastien Ravel, Souhila Amanzougarene, and Francois Sabot
# Version 3 written by Cecile Monat, Christine Tranchant, Cedric Farcy, Maryline Summo, Julie Orjuela-Bouniol, Sebastien Ravel, Gautier Sarah, and Francois Sabot
#
###################################################################################################################################

use strict;
use warnings;
use Test::More 'no_plan';
use Test::Deep;
use fileConfigurator;


#####################
## TOGGLE picardtools ValidateSamFile
#####################

## PATH for datas test
# references files
my $dataRefIrigin = "../DATA/Bank/referenceIrigin.fasta";
my $dataOneBam = "../DATA/testData/samBam/oneBam/";

print "\n\n#################################################\n";
print "#### TEST picardtools ValidateSamFile\n";
print "#################################################\n";


# Remove files and directory created by previous test
my $testingDir="../DATA-TEST/validateSamFile-noSGE-Blocks";
my $cleaningCmd="rm -Rf $testingDir";
system ($cleaningCmd) and die ("ERROR: $0 : Cannot remove the previous test directory with the command $cleaningCmd \n$!\n");

#Creating config file for this test
my @listSoft = ("picardToolsValidateSamFile");
fileConfigurator::createFileConf(\@listSoft,"blockTestConfig.txt");

my $runCmd = "toggleGenerator.pl -c blockTestConfig.txt -d ".$dataOneBam." -r ".$dataRefIrigin." -o ".$testingDir;
print "\n### Toggle running : $runCmd\n";
system("$runCmd") and die "#### ERROR : Can't run TOGGLE for picardToolsValidateSamFile";

# check final results
print "\n### TEST Ouput list & content : $runCmd\n";
my $observedOutput = `ls $testingDir/output/RC3-SAMTOOLSVIEW/1_picardToolsValidateSamFile/`;
my @observedOutput = split /\n/,$observedOutput;
my @expectedOutput = ('RC3-SAMTOOLSVIEW.PICARDTOOLSVALIDATESAMFILE.report');

# expected output test
is_deeply(\@observedOutput,\@expectedOutput,'toggleGenerator - One Bam (no SGE) validatingSam file list');

# expected output content
$observedOutput=`wc -l $testingDir/output/RC3-SAMTOOLSVIEW/1_picardToolsValidateSamFile/RC3-SAMTOOLSVIEW.PICARDTOOLSVALIDATESAMFILE.report`; # We pick up only the position field
chomp $observedOutput;
is($observedOutput,"34 $testingDir/output/RC3-SAMTOOLSVIEW/1_picardToolsValidateSamFile/RC3-SAMTOOLSVIEW.PICARDTOOLSVALIDATESAMFILE.report", 'toggleGenerator - One Bam (no SGE) validatingSam content');

print "\n\n#################################################\n";
print "#### TEST picardtools AddOrReplaceReadGroups\n";
print "#################################################\n";


# Remove files and directory created by previous test
$testingDir="../DATA-TEST/addOrReplaceReadGroups-noSGE-Blocks";
$cleaningCmd="rm -Rf $testingDir";
system ($cleaningCmd) and die ("ERROR: $0 : Cannot remove the previous test directory with the command $cleaningCmd \n$!\n");

#Creating config file for this test
@listSoft = ("picardToolsAddOrReplaceReadGroups");
fileConfigurator::createFileConf(\@listSoft,"blockTestConfig.txt");

$runCmd = "toggleGenerator.pl -c blockTestConfig.txt -d ".$dataOneBam." -r ".$dataRefIrigin." -o ".$testingDir;
print "\n### Toggle running : $runCmd\n";
system("$runCmd") and die "#### ERROR : Can't run TOGGLE for picardToolsAddOrReplaceReadGroups";

# check final results
print "\n### TEST Ouput list & content : $runCmd\n";
$observedOutput = `ls $testingDir/finalResults`;
@observedOutput = split /\n/,$observedOutput;
@expectedOutput = ('RC3-SAMTOOLSVIEW.PICARDTOOLSADDORREPLACEREADGROUPS.bam');

# expected output test
is_deeply(\@observedOutput,\@expectedOutput,'toggleGenerator - One Bam (no SGE) AddOrReplaceReadGroups file list ');

# expected output content
$observedOutput=`samtools view -H $testingDir/finalResults/RC3-SAMTOOLSVIEW.PICARDTOOLSADDORREPLACEREADGROUPS.bam| grep \@RG`; # We pick up only the position field
chomp $observedOutput;
is($observedOutput,"\@RG	ID:Test	LB:Irigin	PL:Illumina	SM:glaberrima	PU:unit1", 'toggleGenerator - One Bam (no SGE) AddOrReplaceReadGroups content');
