<?php

class TMeuObjeto
{
   public $Id;
   public $Nome;         
}

$oMeuObjeto = new TMeuObjeto;

$oMeuObjeto -> Id = 1;
$oMeuObjeto -> Nome = 'nome via php';


$url  = 'http://localhost:8081/datasnap/rest/TMinhaClasse/updateLerDadosJsonValue/';

$url .= json_encode( $oMeuObjeto ) ;

echo $url;


$url = 'http://localhost:8081/datasnap/rest/TMinhaClasse/updateLerDadosJsonValue/{"Id":"1","Nome":"nome via php"}';

$page = file($url) ;  

$show = json_decode($page[0]);

echo '<pre>';

print_r ($show);

echo '</pre>';

?>