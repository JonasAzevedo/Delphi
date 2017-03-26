unit unVariaveis;

interface

  type
    TTiposCadastro = (lote,unico);
    TTipoCadastro = set of TTiposCadastro;

  type
    TCamposObrigatorios = (emails,caracSeparador,relevancia,meioCaptacao,verificEmailNome);
    TCampoObrigatorio = set of TCamposObrigatorios;

implementation

end.
