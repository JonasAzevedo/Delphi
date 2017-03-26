 <?php
  class TMeuObjeto{
    public $FiID;
    public $FsNome;         
  }
  
  $oMeuObjeto = new TMeuObjeto;
  $oMeuObjeto -> FiID = 1;
  $oMeuObjeto -> FsNome = 'nome via php';  
  
    $url  = 'http://localhost:8081/datasnap/rest/TMinhaClasse/LerDadosJsonValue/';
  
  $sJson = '{"type":"uObjeto.TMeuObjeto","id":1,"fields":';
  
  $sJson .= json_encode($oMeuObjeto) ;
  $sJson .= '}';
  
  
  $ch = curl_init() ;
  curl_setopt( $ch , CURLOPT_HTTPHEADER, array ( "Accept: application/json" , "Content-Type: application/json; charset=utf-8" ) ) ;
  curl_setopt( $ch , CURLOPT_HEADER , FALSE ) ;
  curl_setopt( $ch , CURLOPT_RETURNTRANSFER , true ) ;
  curl_setopt( $ch , CURLOPT_POST , TRUE ) ;
  curl_setopt( $ch , CURLOPT_URL , $url ) ;
  curl_setopt( $ch , CURLOPT_POSTFIELDS , $sJson) ;
  $result = curl_exec( $ch ) ;
 
 echo '<pre>';
 print_r ($result);
 echo '</pre>'
?>