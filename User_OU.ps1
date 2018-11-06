Import-Module ActiveDirectory

#
#Le bloc de code ci dessous sert a enlever tout les caractères spéciaux
#

$A_c = ([char]0x0041,[char]0x24B6,[char]0xFF21,[char]0x00C0,[char]0x00C1,[char]0x00C2,[char]0x1EA6,[char]0x1EA4,[char]0x1EAA,[char]0x1EA8,[char]0x00C3,[char]0x0100,[char]0x0102,[char]0x1EB0,[char]0x1EAE,[char]0x1EB4,[char]0x1EB2,[char]0x0226,[char]0x01E0,[char]0x00C4,[char]0x01DE,[char]0x1EA2,[char]0x00C5,[char]0x01FA,[char]0x01CD,[char]0x0200,[char]0x0202,[char]0x1EA0,[char]0x1EAC,[char]0x1EB6,[char]0x1E00,[char]0x0104,[char]0x023A,[char]0x2C6F)
$AA_c = ([char]0xA732)
$AE_c = ([char]0x00C6,[char]0x01FC,[char]0x01E2)
$AO_c = ([char]0xA734)
$AU_c = ([char]0xA736)
$AV_c = ([char]0xA738,[char]0xA73A)
$AY_c = ([char]0xA73C)
$B_c = ([char]0x0042,[char]0x24B7,[char]0xFF22,[char]0x1E02,[char]0x1E04,[char]0x1E06,[char]0x0243,[char]0x0182,[char]0x0181)
$C_c = ([char]0x0043,[char]0x24B8,[char]0xFF23,[char]0x0106,[char]0x0108,[char]0x010A,[char]0x010C,[char]0x00C7,[char]0x1E08,[char]0x0187,[char]0x023B,[char]0xA73E)
$D_c = ([char]0x0044,[char]0x24B9,[char]0xFF24,[char]0x1E0A,[char]0x010E,[char]0x1E0C,[char]0x1E10,[char]0x1E12,[char]0x1E0E,[char]0x0110,[char]0x018B,[char]0x018A,[char]0x0189,[char]0xA779)
$DZ_c = ([char]0x01F1,[char]0x01C4)
$Dz_cs = ([char]0x01F2,[char]0x01C5)
$E_c = ([char]0x0045,[char]0x24BA,[char]0xFF25,[char]0x00C8,[char]0x00C9,[char]0x00CA,[char]0x1EC0,[char]0x1EBE,[char]0x1EC4,[char]0x1EC2,[char]0x1EBC,[char]0x0112,[char]0x1E14,[char]0x1E16,[char]0x0114,[char]0x0116,[char]0x00CB,[char]0x1EBA,[char]0x011A,[char]0x0204,[char]0x0206,[char]0x1EB8,[char]0x1EC6,[char]0x0228,[char]0x1E1C,[char]0x0118,[char]0x1E18,[char]0x1E1A,[char]0x0190,[char]0x018E)
$F_c = ([char]0x0046,[char]0x24BB,[char]0xFF26,[char]0x1E1E,[char]0x0191,[char]0xA77B)
$G_c = ([char]0x0047,[char]0x24BC,[char]0xFF27,[char]0x01F4,[char]0x011C,[char]0x1E20,[char]0x011E,[char]0x0120,[char]0x01E6,[char]0x0122,[char]0x01E4,[char]0x0193,[char]0xA7A0,[char]0xA77D,[char]0xA77E)
$H_c = ([char]0x0048,[char]0x24BD,[char]0xFF28,[char]0x0124,[char]0x1E22,[char]0x1E26,[char]0x021E,[char]0x1E24,[char]0x1E28,[char]0x1E2A,[char]0x0126,[char]0x2C67,[char]0x2C75,[char]0xA78D)
$I_c = ([char]0x0049,[char]0x24BE,[char]0xFF29,[char]0x00CC,[char]0x00CD,[char]0x00CE,[char]0x0128,[char]0x012A,[char]0x012C,[char]0x0130,[char]0x00CF,[char]0x1E2E,[char]0x1EC8,[char]0x01CF,[char]0x0208,[char]0x020A,[char]0x1ECA,[char]0x012E,[char]0x1E2C,[char]0x0197)
$J_c = ([char]0x004A,[char]0x24BF,[char]0xFF2A,[char]0x0134,[char]0x0248)
$K_c = ([char]0x004B,[char]0x24C0,[char]0xFF2B,[char]0x1E30,[char]0x01E8,[char]0x1E32,[char]0x0136,[char]0x1E34,[char]0x0198,[char]0x2C69,[char]0xA740,[char]0xA742,[char]0xA744,[char]0xA7A2)
$L_c = ([char]0x004C,[char]0x24C1,[char]0xFF2C,[char]0x013F,[char]0x0139,[char]0x013D,[char]0x1E36,[char]0x1E38,[char]0x013B,[char]0x1E3C,[char]0x1E3A,[char]0x0141,[char]0x023D,[char]0x2C62,[char]0x2C60,[char]0xA748,[char]0xA746,[char]0xA780)
$LJ_c = ([char]0x01C7)
$Lj_cs = ([char]0x01C8)
$M_c = ([char]0x004D,[char]0x24C2,[char]0xFF2D,[char]0x1E3E,[char]0x1E40,[char]0x1E42,[char]0x2C6E,[char]0x019C)
$N_c = ([char]0x004E,[char]0x24C3,[char]0xFF2E,[char]0x01F8,[char]0x0143,[char]0x00D1,[char]0x1E44,[char]0x0147,[char]0x1E46,[char]0x0145,[char]0x1E4A,[char]0x1E48,[char]0x0220,[char]0x019D,[char]0xA790,[char]0xA7A4)
$NJ_c = ([char]0x01CA)
$Nj_cs = ([char]0x01CB)
$O_c = ([char]0x004F,[char]0x24C4,[char]0xFF2F,[char]0x00D2,[char]0x00D3,[char]0x00D4,[char]0x1ED2,[char]0x1ED0,[char]0x1ED6,[char]0x1ED4,[char]0x00D5,[char]0x1E4C,[char]0x022C,[char]0x1E4E,[char]0x014C,[char]0x1E50,[char]0x1E52,[char]0x014E,[char]0x022E,[char]0x0230,[char]0x00D6,[char]0x022A,[char]0x1ECE,[char]0x0150,[char]0x01D1,[char]0x020C,[char]0x020E,[char]0x01A0,[char]0x1EDC,[char]0x1EDA,[char]0x1EE0,[char]0x1EDE,[char]0x1EE2,[char]0x1ECC,[char]0x1ED8,[char]0x01EA,[char]0x01EC,[char]0x00D8,[char]0x01FE,[char]0x0186,[char]0x019F,[char]0xA74A,[char]0xA74C)
$OI_c = ([char]0x01A2)
$OO_c = ([char]0xA74E)
$OU_c = ([char]0x0222)
$P_c = ([char]0x0050,[char]0x24C5,[char]0xFF30,[char]0x1E54,[char]0x1E56,[char]0x01A4,[char]0x2C63,[char]0xA750,[char]0xA752,[char]0xA754)
$Q_c = ([char]0x0051,[char]0x24C6,[char]0xFF31,[char]0xA756,[char]0xA758,[char]0x024A)
$R_c = ([char]0x0052,[char]0x24C7,[char]0xFF32,[char]0x0154,[char]0x1E58,[char]0x0158,[char]0x0210,[char]0x0212,[char]0x1E5A,[char]0x1E5C,[char]0x0156,[char]0x1E5E,[char]0x024C,[char]0x2C64,[char]0xA75A,[char]0xA7A6,[char]0xA782)
$S_c = ([char]0x0053,[char]0x24C8,[char]0xFF33,[char]0x1E9E,[char]0x015A,[char]0x1E64,[char]0x015C,[char]0x1E60,[char]0x0160,[char]0x1E66,[char]0x1E62,[char]0x1E68,[char]0x0218,[char]0x015E,[char]0x2C7E,[char]0xA7A8,[char]0xA784)
$T_c = ([char]0x0054,[char]0x24C9,[char]0xFF34,[char]0x1E6A,[char]0x0164,[char]0x1E6C,[char]0x021A,[char]0x0162,[char]0x1E70,[char]0x1E6E,[char]0x0166,[char]0x01AC,[char]0x01AE,[char]0x023E,[char]0xA786)
$TZ_c = ([char]0xA728)
$U_c = ([char]0x0055,[char]0x24CA,[char]0xFF35,[char]0x00D9,[char]0x00DA,[char]0x00DB,[char]0x0168,[char]0x1E78,[char]0x016A,[char]0x1E7A,[char]0x016C,[char]0x00DC,[char]0x01DB,[char]0x01D7,[char]0x01D5,[char]0x01D9,[char]0x1EE6,[char]0x016E,[char]0x0170,[char]0x01D3,[char]0x0214,[char]0x0216,[char]0x01AF,[char]0x1EEA,[char]0x1EE8,[char]0x1EEE,[char]0x1EEC,[char]0x1EF0,[char]0x1EE4,[char]0x1E72,[char]0x0172,[char]0x1E76,[char]0x1E74,[char]0x0244)
$V_c = ([char]0x0056,[char]0x24CB,[char]0xFF36,[char]0x1E7C,[char]0x1E7E,[char]0x01B2,[char]0xA75E,[char]0x0245)
$VY_c = ([char]0xA760)
$W_c = ([char]0x0057,[char]0x24CC,[char]0xFF37,[char]0x1E80,[char]0x1E82,[char]0x0174,[char]0x1E86,[char]0x1E84,[char]0x1E88,[char]0x2C72)
$X_c = ([char]0x0058,[char]0x24CD,[char]0xFF38,[char]0x1E8A,[char]0x1E8C)
$Y_c = ([char]0x0059,[char]0x24CE,[char]0xFF39,[char]0x1EF2,[char]0x00DD,[char]0x0176,[char]0x1EF8,[char]0x0232,[char]0x1E8E,[char]0x0178,[char]0x1EF6,[char]0x1EF4,[char]0x01B3,[char]0x024E,[char]0x1EFE)
$Z_c = ([char]0x005A,[char]0x24CF,[char]0xFF3A,[char]0x0179,[char]0x1E90,[char]0x017B,[char]0x017D,[char]0x1E92,[char]0x1E94,[char]0x01B5,[char]0x0224,[char]0x2C7F,[char]0x2C6B,[char]0xA762)
$a = ([char]0x0061,[char]0x24D0,[char]0xFF41,[char]0x1E9A,[char]0x00E0,[char]0x00E1,[char]0x00E2,[char]0x1EA7,[char]0x1EA5,[char]0x1EAB,[char]0x1EA9,[char]0x00E3,[char]0x0101,[char]0x0103,[char]0x1EB1,[char]0x1EAF,[char]0x1EB5,[char]0x1EB3,[char]0x0227,[char]0x01E1,[char]0x00E4,[char]0x01DF,[char]0x1EA3,[char]0x00E5,[char]0x01FB,[char]0x01CE,[char]0x0201,[char]0x0203,[char]0x1EA1,[char]0x1EAD,[char]0x1EB7,[char]0x1E01,[char]0x0105,[char]0x2C65,[char]0x0250)
$aa = ([char]0xA733)
$ae = ([char]0x00E6,[char]0x01FD,[char]0x01E3)
$ao = ([char]0xA735)
$au = ([char]0xA737)
$av = ([char]0xA739,[char]0xA73B)
$ay = ([char]0xA73D)
$b = ([char]0x0062,[char]0x24D1,[char]0xFF42,[char]0x1E03,[char]0x1E05,[char]0x1E07,[char]0x0180,[char]0x0183,[char]0x0253)
$c = ([char]0x0063,[char]0x24D2,[char]0xFF43,[char]0x0107,[char]0x0109,[char]0x010B,[char]0x010D,[char]0x00E7,[char]0x1E09,[char]0x0188,[char]0x023C,[char]0xA73F,[char]0x2184)
$d = ([char]0x0064,[char]0x24D3,[char]0xFF44,[char]0x1E0B,[char]0x010F,[char]0x1E0D,[char]0x1E11,[char]0x1E13,[char]0x1E0F,[char]0x0111,[char]0x018C,[char]0x0256,[char]0x0257,[char]0xA77A)
$dz = ([char]0x01F3,[char]0x01C6)
$e = ([char]0x0065,[char]0x24D4,[char]0xFF45,[char]0x00E8,[char]0x00E9,[char]0x00EA,[char]0x1EC1,[char]0x1EBF,[char]0x1EC5,[char]0x1EC3,[char]0x1EBD,[char]0x0113,[char]0x1E15,[char]0x1E17,[char]0x0115,[char]0x0117,[char]0x00EB,[char]0x1EBB,[char]0x011B,[char]0x0205,[char]0x0207,[char]0x1EB9,[char]0x1EC7,[char]0x0229,[char]0x1E1D,[char]0x0119,[char]0x1E19,[char]0x1E1B,[char]0x0247,[char]0x025B,[char]0x01DD)
$f = ([char]0x0066,[char]0x24D5,[char]0xFF46,[char]0x1E1F,[char]0x0192,[char]0xA77C)
$g = ([char]0x0067,[char]0x24D6,[char]0xFF47,[char]0x01F5,[char]0x011D,[char]0x1E21,[char]0x011F,[char]0x0121,[char]0x01E7,[char]0x0123,[char]0x01E5,[char]0x0260,[char]0xA7A1,[char]0x1D79,[char]0xA77F)
$h = ([char]0x0068,[char]0x24D7,[char]0xFF48,[char]0x0125,[char]0x1E23,[char]0x1E27,[char]0x021F,[char]0x1E25,[char]0x1E29,[char]0x1E2B,[char]0x1E96,[char]0x0127,[char]0x2C68,[char]0x2C76,[char]0x0265)
$hv = ([char]0x0195)
$i = ([char]0x0069,[char]0x24D8,[char]0xFF49,[char]0x00EC,[char]0x00ED,[char]0x00EE,[char]0x0129,[char]0x012B,[char]0x012D,[char]0x00EF,[char]0x1E2F,[char]0x1EC9,[char]0x01D0,[char]0x0209,[char]0x020B,[char]0x1ECB,[char]0x012F,[char]0x1E2D,[char]0x0268,[char]0x0131)
$j = ([char]0x006A,[char]0x24D9,[char]0xFF4A,[char]0x0135,[char]0x01F0,[char]0x0249)
$k = ([char]0x006B,[char]0x24DA,[char]0xFF4B,[char]0x1E31,[char]0x01E9,[char]0x1E33,[char]0x0137,[char]0x1E35,[char]0x0199,[char]0x2C6A,[char]0xA741,[char]0xA743,[char]0xA745,[char]0xA7A3)
$l = ([char]0x006C,[char]0x24DB,[char]0xFF4C,[char]0x0140,[char]0x013A,[char]0x013E,[char]0x1E37,[char]0x1E39,[char]0x013C,[char]0x1E3D,[char]0x1E3B,[char]0x017F,[char]0x0142,[char]0x019A,[char]0x026B,[char]0x2C61,[char]0xA749,[char]0xA781,[char]0xA747)
$lj = ([char]0x01C9)
$m = ([char]0x006D,[char]0x24DC,[char]0xFF4D,[char]0x1E3F,[char]0x1E41,[char]0x1E43,[char]0x0271,[char]0x026F)
$n = ([char]0x006E,[char]0x24DD,[char]0xFF4E,[char]0x01F9,[char]0x0144,[char]0x00F1,[char]0x1E45,[char]0x0148,[char]0x1E47,[char]0x0146,[char]0x1E4B,[char]0x1E49,[char]0x019E,[char]0x0272,[char]0x0149,[char]0xA791,[char]0xA7A5)
$nj = ([char]0x01CC)
$o = ([char]0x006F,[char]0x24DE,[char]0xFF4F,[char]0x00F2,[char]0x00F3,[char]0x00F4,[char]0x1ED3,[char]0x1ED1,[char]0x1ED7,[char]0x1ED5,[char]0x00F5,[char]0x1E4D,[char]0x022D,[char]0x1E4F,[char]0x014D,[char]0x1E51,[char]0x1E53,[char]0x014F,[char]0x022F,[char]0x0231,[char]0x00F6,[char]0x022B,[char]0x1ECF,[char]0x0151,[char]0x01D2,[char]0x020D,[char]0x020F,[char]0x01A1,[char]0x1EDD,[char]0x1EDB,[char]0x1EE1,[char]0x1EDF,[char]0x1EE3,[char]0x1ECD,[char]0x1ED9,[char]0x01EB,[char]0x01ED,[char]0x00F8,[char]0x01FF,[char]0x0254,[char]0xA74B,[char]0xA74D,[char]0x0275)
$oi = ([char]0x01A3)
$ou = ([char]0x0223)
$oo = ([char]0xA74F)
$p = ([char]0x0070,[char]0x24DF,[char]0xFF50,[char]0x1E55,[char]0x1E57,[char]0x01A5,[char]0x1D7D,[char]0xA751,[char]0xA753,[char]0xA755)
$q = ([char]0x0071,[char]0x24E0,[char]0xFF51,[char]0x024B,[char]0xA757,[char]0xA759)
$r = ([char]0x0072,[char]0x24E1,[char]0xFF52,[char]0x0155,[char]0x1E59,[char]0x0159,[char]0x0211,[char]0x0213,[char]0x1E5B,[char]0x1E5D,[char]0x0157,[char]0x1E5F,[char]0x024D,[char]0x027D,[char]0xA75B,[char]0xA7A7,[char]0xA783)
$s = ([char]0x0073,[char]0x24E2,[char]0xFF53,[char]0x00DF,[char]0x015B,[char]0x1E65,[char]0x015D,[char]0x1E61,[char]0x0161,[char]0x1E67,[char]0x1E63,[char]0x1E69,[char]0x0219,[char]0x015F,[char]0x023F,[char]0xA7A9,[char]0xA785,[char]0x1E9B)
$t = ([char]0x0074,[char]0x24E3,[char]0xFF54,[char]0x1E6B,[char]0x1E97,[char]0x0165,[char]0x1E6D,[char]0x021B,[char]0x0163,[char]0x1E71,[char]0x1E6F,[char]0x0167,[char]0x01AD,[char]0x0288,[char]0x2C66,[char]0xA787)
$tz = ([char]0xA729)
$u = ([char]0x0075,[char]0x24E4,[char]0xFF55,[char]0x00F9,[char]0x00FA,[char]0x00FB,[char]0x0169,[char]0x1E79,[char]0x016B,[char]0x1E7B,[char]0x016D,[char]0x00FC,[char]0x01DC,[char]0x01D8,[char]0x01D6,[char]0x01DA,[char]0x1EE7,[char]0x016F,[char]0x0171,[char]0x01D4,[char]0x0215,[char]0x0217,[char]0x01B0,[char]0x1EEB,[char]0x1EE9,[char]0x1EEF,[char]0x1EED,[char]0x1EF1,[char]0x1EE5,[char]0x1E73,[char]0x0173,[char]0x1E77,[char]0x1E75,[char]0x0289)
$v = ([char]0x0076,[char]0x24E5,[char]0xFF56,[char]0x1E7D,[char]0x1E7F,[char]0x028B,[char]0xA75F,[char]0x028C)
$vy = ([char]0xA761)
$w = ([char]0x0077,[char]0x24E6,[char]0xFF57,[char]0x1E81,[char]0x1E83,[char]0x0175,[char]0x1E87,[char]0x1E85,[char]0x1E98,[char]0x1E89,[char]0x2C73)
$x = ([char]0x0078,[char]0x24E7,[char]0xFF58,[char]0x1E8B,[char]0x1E8D)
$y = ([char]0x0079,[char]0x24E8,[char]0xFF59,[char]0x1EF3,[char]0x00FD,[char]0x0177,[char]0x1EF9,[char]0x0233,[char]0x1E8F,[char]0x00FF,[char]0x1EF7,[char]0x1E99,[char]0x1EF5,[char]0x01B4,[char]0x024F,[char]0x1EFF)
$z = ([char]0x007A,[char]0x24E9,[char]0xFF5A,[char]0x017A,[char]0x1E91,[char]0x017C,[char]0x017E,[char]0x1E93,[char]0x1E95,[char]0x01B6,[char]0x0225,[char]0x0240,[char]0x2C6C,[char]0xA763)

$varARR = @('$A_c','$AA_c','$AE_c','$AO_c','$AU_c','$AV_c','$AY_c','$B_c','$C_c','$D_c','$DZ_c','$Dz_cs','$E_c','$F_c','$G_c','$H_c','$I_c','$J_c','$K_c','$L_c','$LJ_c','$Lj_cs','$M_c','$N_c','$NJ_c','$Nj_cs','$O_c','$OI_c','$OO_c','$OU_c','$P_c','$Q_c','$R_c','$S_c','$T_c','$TZ_c','$U_c','$V_c','$VY_c','$W_c','$X_c','$Y_c','$Z_c','$a','$aa','$ae','$ao','$au','$av','$ay','$b','$c','$d','$dz','$e','$f','$g','$h','$hv','$i','$j','$k','$l','$lj','$m','$n','$nj','$o','$oi','$ou','$oo','$p','$q','$r','$s','$t','$tz','$u','$v','$vy','$w','$x','$y','$z')

function regulate #onction de remplacement des caractère spéciaux
{
    param( $string )
    $string = [char[]]$string
    $regulated=''

    $string | foreach{
                        $truse=0
                        $eachLetter = $_
                        foreach ($v in $varARR)
                                {
                                $v -match "[a-z]+" | out-null
                                $varname=$matches.Values
                                $anotherVar = (Get-Variable $v.substring(1)).Value
                                if ($anotherVar -ccontains $eachLetter)
                                    {$regulated = $regulated + $varname
                                        $truse=1
                                    }
                                }
                        if ($truse -eq 0) {$regulated = $regulated + $eachLetter}
                    }
                    $regulated = $regulated -replace "œ","oe"
                    $regulated = $regulated -replace "Œ","OE"
                    $regulated = $regulated -replace "î","i"
                    $regulated = $regulated -replace "ï","i"
                     $regulated = $regulated -replace "é","e"
                     $regulated = $regulated -replace "è","e"
    return $regulated
}

function New-RandomPassword
{
    $randonInt = Get-Random -Minimum 10 -Maximum 99
    $letter = ([char[]]([char]65..[char]90) + ([char[]]([char]97..[char]122)))
    $specialChar = ([char[]]([char]33..[char]46) + ([char[]]([char]58..[char]64)) + ([char[]]([char]123..[char]126)))
    $randomLetter = ""
    $randomChar = ""
    for($i = 0; $i -lt 4; $i++)
    {
        $x = Get-Random -Minimum 0 -Maximum $letter.Count
        $randomLetter += $letter[$x]
    }
    $charIndex = Get-Random -Minimum 0 -Maximum $specialChar.Count
    $randomChar = $specialChar[$charIndex]
    $password = $randomLetter + $randomChar + $randonInt.ToString()
    $shuffledPwd = -join($password -split''|sort{Get-Random})
    return $shuffledPwd
}
function New-RandomDirectorPassword
{
    $randonInt = Get-Random -Minimum 10000 -Maximum 99999
    $letter = ([char[]]([char]65..[char]90) + ([char[]]([char]97..[char]122)))
    $specialChar = ([char[]]([char]33..[char]46) + ([char[]]([char]58..[char]64)) + ([char[]]([char]123..[char]126)))
    $randomLetter = ""
    $randomChar = ""
    for($i = 0; $i -lt 8; $i++)
    {
        $x = Get-Random -Minimum 0 -Maximum $letter.Count
        $randomLetter += $letter[$x]
    }
    for($i = 0; $i -lt 2; $i++)
    {
        $charIndex = Get-Random -Minimum 0 -Maximum $specialChar.Count
        $randomChar += $specialChar[$charIndex]
    }
    $password = $randomLetter + $randomChar + $randonInt.ToString()
    $shuffledPwd = -join($password -split''|sort{Get-Random})
    return $shuffledPwd
}

$employees = Import-Csv -Delimiter ";" C:\Employées.csv # importation du csv
$listOfDepartement = New-Object System.Collections.Generic.List[System.Object] #creation d'un tableau des OU
$dc = Read-Host "DC " #Lecture des dc
$tld = Read-Host "Foret  "
foreach($e in $employees)#Séparation des ou mères et enfants 
{
    $departement = New-Object System.Collections.Generic.List[System.Object]
    $splited = $e.Département -split '/'
    [array]::Reverse($splited)
    for($i=0; $i -lt $splited.Length; $i++)
    {
        $departement.Add($splited[$i])
        
    }
    
    $listOfDepartement.Add($departement)
    
}
$sortedArray =$listOfDepartement | Sort-Object | Get-Unique #tri des OU et suppréssion des doublons


Write-Host "Creating OUs"
for($i=0;$i-lt $sortedArray.Count;$i++)
{
    $regOUMain = regulate($sortedArray[$i][0])
    $regOUMain = $regOUMain -replace " ",""
    Write-Host "OU Mère: " $regOUMain
    try
    {
        New-ADOrganizationalUnit -Name $regOUMain -Path ("DC="+$dc+",DC="+$tld) -ProtectedFromAccidentalDeletion $False #Ajoute l'ou mère
        Get-ADForest | Set-ADForest -UPNSuffixes @{add=($regOUMain +".lan").ToLower() } # Crée un suffix upn par ou mère
    }
    catch
    {
        Write-Host "OU already existing, creating child" #Gère si l'ou existe déja
    }
    for($j = 1; $j -lt $sortedArray[$i].Count; $j++)
    {
        $regOU = regulate($sortedArray[$i][$j])
        $regOU = $regOU -replace " ",""
        Write-Host "OU Enfant: " $regOU
        New-ADOrganizationalUnit -Name $regOU -Path ("OU="+$regOUMain+",DC="+$dc+",DC="+$tld) -ProtectedFromAccidentalDeletion $False # Crèe l'ou enfant
    }
    Write-Host '------'
}
$date = Get-Date -UFormat "%Y-%m-%d_%H-%M-%S"
Write-Host "Creating Users"
foreach($e in $employees)
{
    $regPrenom = regulate($e.Prénom)
    $regNom = regulate($e.Nom)
    $regDep = regulate($e.Département)
    $dep = $regDep -split '/'
    [array]::Reverse($dep)
    $OUMain = regulate($dep[0])
    $OUChild = regulate($dep[1])
    $oName = $regPrenom[0]+$regPrenom[1]+$regPrenom[2]+"."+$regNom
    $SAM = $regPrenom+$regNom
    $UPNtemp = $oName.ToLower()+ "@" + $OUMain.ToLower() + ".lan"
    $UPN = $UPNtemp -replace " ",""
    $path = "OU="+$OUMain+",DC="+$dc+",DC="+$tld
    
    #$oName
    #$UPN
    #$path
    
    
    if($dep.Count -eq 1)# Crée un utilisateur dans une ou qui n'a pas d'enfant
    {
    
    $regOName = $oName -replace " ",""
    Write-Host "Creating $($regOName) in Department $($path)"
    $passwd = New-RandomDirectorPassword
       New-ADUser -Name $($regPrenom + " " + $regNom) -GivenName $regPrenom -Surname $regNom -Description $e.Description -Initials ($regPrenom[0]+$regNom[0]) -Department $e.Département -SamAccountName $regOName -UserPrincipalName $UPN -Office $e.Bureau -OfficePhone $e.'N° interne'-Path $path -AccountPassword $(ConvertTo-SecureString -AsPlainText $passwd -Force) -ChangePasswordAtLogon $true -Enabled $true
       $UPN+";"+$passwd>> "c:\\Users$($date.ToString()).csv"
       Write-Host "Creating user $($regOName) with password $($passwd)"
    Write-Host "Done"
    }
    else # Crée un utilisateur dans les ou enfant
    {
        $a = $OUChild -replace " ",""
        $b = $OUMain -replace " ",""
        $path = "OU="+$a+",OU="+$b+",DC="+$dc+",DC="+$tld
        $regOName = $oName -replace " ",""
        try
        {
            $passwd = New-RandomPassword
            Write-Host "Creating $($regOName) in Department $($path)"
            New-ADUser -Name $($regPrenom + " " + $regNom) -GivenName $regPrenom -Surname $regNom -Description $e.Description -Initials ($regPrenom[0]+$regNom[0]) -Department $e.Département -SamAccountName $regOName -UserPrincipalName $UPN -Office $e.Bureau -OfficePhone $e.'N° interne' -Path $path -AccountPassword $(ConvertTo-SecureString -AsPlainText $passwd -Force) -ChangePasswordAtLogon $true -Enabled $true
            $UPN+";"+$passwd >> "c:\\Users$($date.ToString()).csv"
            Write-Host "Creating user $($reOName) with password $($passwd)"
            Write-Host "Done"
        }
        catch
        {
            $passwd = New-RandomPassword
            $filePath = "c:\\TrimedName$($date.ToString()).csv"
            Write-Host "$($regOName) is too long($($regOName.Length)) wrinting log on file $($filePath) "
            "SamAccountName:'$($regOName)';Prénom:'$($regPrenom)';Nom:'$($regNom)';UPN:'$($UPN)';Bureau:'$($e.Bureau)';N°Interne:'$($e.'N° interne')';Path:'$($path)';Password:'$($passwd)'" >> $filePath
        }   
    }
}
