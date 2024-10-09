unit server.entities.empresa;

interface

uses
  server.entities.endereco,
  server.entities.emissorfiscal;

type
  TEmpresa = class
  private
    FId: String;
    FNome: String;
    FTelefone: String;
    FEmail: String;
    FInscricaoEstadual: String;
    FInscricaoEstadualST: String;
    FInscricaoMunicipal: String;
    FCRT: Integer;
    FLogotipo: String;
    FRegime: Integer;
    FCreateAt: TDateTime;
    FUpdate: TDateTime;
    FEndereco: TEndereco;
    FEmissorFiscal: TEmissorFiscal;
    FCNPJ: String;
  public
    property Id: String read FId write FId;
    property CNPJ: String read FCNPJ write FCNPJ;
    property Nome: String read FNome write FNome;
    property Telefone: String read FTelefone write FTelefone;
    property Email: String read FEmail write FEmail;
    property InscricaoEstadual: String read FInscricaoEstadual write FInscricaoEstadual;
    property InscricaoEstadualST: String read FInscricaoEstadualST write FInscricaoEstadualST;
    property InscricaoMunicipal: String read FInscricaoMunicipal write FInscricaoMunicipal;
    property CRT: Integer read FCRT write FCRT;
    property Logotipo: String read FLogotipo write FLogotipo;
    property Regime: Integer read FRegime write FRegime;
    property Endereco: TEndereco read FEndereco write FEndereco;
    property EmissorFiscal: TEmissorFiscal read FEmissorFiscal write FEmissorFiscal;
    property CreatedAt: TDateTime read FCreateAt write FCreateAt;
    property UpdatedAt: TDateTime read FUpdate write FUpdate;
  end;

implementation

end.
