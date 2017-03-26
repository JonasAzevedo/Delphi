unit unCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmCliente = class(TForm)
    lblNome: TLabel;
    lblEndereco: TLabel;
    lblTelefone: TLabel;
    lblValorNome: TLabel;
    lblValorEndereco: TLabel;
    lblValorTelefone: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    nome,endereco,telefone: String;
    procedure setNome(const value: String);
    procedure setEndereco(const value: String);
    procedure setTelefone(const value: String);
    function getNome: String;
    function getEndereco: String;
    function getTelefone: String;
  published
    property proNome: string read getNome write setNome;
    property proEndereco: string read getEndereco write setEndereco;
    property proTelefone: string read getTelefone write setTelefone;
  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.DFM}

{ TfrmCliente }

{ TfrmCliente }


function TfrmCliente.getEndereco: String;
begin
  Result := endereco;
end;

function TfrmCliente.getNome: String;
begin
  Result := nome;
end;

function TfrmCliente.getTelefone: String;
begin
  Result := telefone;
end;

procedure TfrmCliente.setEndereco(const value: String);
begin
  endereco := value;
  lblValorEndereco.Caption := endereco;
end;

procedure TfrmCliente.setNome(const value: String);
begin
  if(trim(value) = '')then
    raise Exception.Create('Nome não pode ser vazio!')
  else
  begin
    nome := value;
    lblValorNome.Caption := nome;
    Self.Caption := nome;
  end;
end;

procedure TfrmCliente.setTelefone(const value: String);
begin
  telefone := value;
  lblValorTelefone.Caption := telefone;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  proNome := 'a';
end;

end.
