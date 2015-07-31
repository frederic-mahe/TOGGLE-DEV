package namingConvention;

###################################################################################################################################
#
# Copyright 2014-2015 IRD-CIRAD
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
# Intellectual property belongs to IRD, CIRAD and South Green developpement plateform
# Written by Cecile Monat, Christine Tranchant, Ayite Kougbeadjo, Cedric Farcy, Mawusse Agbessi, Marilyne Summo, and Francois Sabot
#
###################################################################################################################################

###################################################################################################################################
#
# This package will change the names of softwares to be coherent through the toggle hashes.
#
###################################################################################################################################




use strict;
use warnings;
use Data::Dumper;
use Switch;

use lib qw(.);
use localConfig;


sub softwareNomenclature # Will rewrite the correct name in the hash of configuration
{
    my ($hash) = @_;
    
    foreach my $currentSoft (keys $hash)
    {
        my $correctName;
        if ($currentSoft eq "order") # We aredealing with the order hash...
        {
            #Specific treatment
            
            next;
        }
        $correctName=correctName($currentSoft);
        $$hash{$correctName}=$$hash{$currentSoft};
        undef $$hash{$currentSoft};
    }
    return $hash;
}

sub correctName
{
    my ($name)=@_;
    my $correctedName="NA";
    
    switch
    {
        #FOR bwa.pm
        case ($name =~ m/bwa[\s*]aln/i){$correctedName="bwaAln"} #Correction for bwaAln
        case ($name =~ m/bwa[\s*]sampe/i){$correctedName="bwaSampe"} # Correction for bwaSampe
        case ($name =~ m/bwa[\s*]index/i){$correctedName="bwaIndex"} # Correction for bwaIndex
        
        #FOR samTools.pm
        
        #FOR picardTools.pm
        
        #FOR gatk.pm
        
        #FOR fastqc.pm
        
        #FOR tophat.pm
        
        
    }
    return $correctedName;
}

1;
