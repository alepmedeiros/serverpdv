unit service.repository.impl.empresa;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Data.DB,
  service.repository.interfaces,
  server.entities.empresa,
  server.connections.interfaces,
  server.entities.endereco,
  server.entities.emissorfiscal;

type
  TRepositoryEmpresa = class(TInterfacedObject, IRepository<TEmpresa>)
  private
    FEmpresa: TEmpresa;
    FEmpresas: TObjectList<TEmpresa>;
    FConn: IDataBaseConnection;

    constructor Create;
    destructor Destroy; override;
  public
    class function New: IRepository<TEmpresa>;

    function Listar: IRepository<TEmpresa>;
    function ListarPorId(Value: String): IRepository<TEmpresa>;
    function Excluir(Value: String): IRepository<TEmpresa>;
    function Atualizar: IRepository<TEmpresa>;
    function Inserir: IRepository<TEmpresa>;
    function This: TEmpresa;
    function These: TObjectList<TEmpresa>;
  end;

implementation

uses
  server.connections.impl.firedac;

{ TRepositoryEmpresa }

function TRepositoryEmpresa.Atualizar: IRepository<TEmpresa>;
begin
  Result := Self;
  var LSQL := 
  'UPDATE api.empresas SET '+
  'nome=:nome, cnpj=:cnpj, telefone=:telefone, email=:emal, inscricaoestadual=:inscricaoestadual,'+
  'inscricaoestadualst=:inscricaoestadualst, inscricaomunicipal=:inscricaomunicipal,'+
  ' crt=:crt, logotipo=:logotipo, regime=:regime WHERE id=:id';
  var LData := TDataSource.Create(nil);
  FConn.Query(LSQL,[FEmpresa.Nome, FEmpresa.CNPJ, FEmpresa.Telefone,
  FEmpresa.Email, FEmpresa.InscricaoEstadual,
  FEmpresa.InscricaoEstadualST, FEmpresa.InscricaoMunicipal,
  FEmpresa.CRT, FEmpresa.Logotipo, FEmpresa.Regime, FEmpresa.Id], LData);
end;

constructor TRepositoryEmpresa.Create;
begin
  FEmpresa := TEmpresa.Create;
  FEmpresas:= TObjectList<TEmpresa>.Create;
  FConn := TDataBaseConnection.New;
end;

destructor TRepositoryEmpresa.Destroy;
begin
  FEmpresa.Free;
  FEmpresa.Free;
  inherited;
end;

function TRepositoryEmpresa.Excluir(Value: String): IRepository<TEmpresa>;
begin
  Result := Self;
  var Ldata := TDataSource.Create(nil);
  FConn.Query('delete from empresas where id = :id', [Value], Ldata);
end;

function TRepositoryEmpresa.Inserir: IRepository<TEmpresa>;
begin
  Result := Self;
  var LSQL := 'INSERT INTO api.empresas '+
  '(nome, cnpj, telefone, email, inscricaoestadual, inscricaoestadualst, '+
  'inscricaomunicipal, crt, logotipo, regime) VALUES '+
  '(:nome, :cnpj, :telefone, :email, :inscricaoestadual, :inscricaoestadualst, '+
  ':inscricaomunicipal, :crt, :logotipo, :regime)';

  var LDataSource := TDataSource.Create(nil);
  FConn.Query(LSQL,
    [FEmpresa.Nome, FEmpresa.CNPJ, FEmpresa.Telefone,
    FEmpresa.Email, FEmpresa.InscricaoEstadual, FEmpresa.InscricaoEstadualST,
    FEmpresa.InscricaoMunicipal, FEmpresa.CRT, FEmpresa.Logotipo, FEmpresa.Regime],LDataSource);
  LDataSource.Free;
end;

function TRepositoryEmpresa.Listar: IRepository<TEmpresa>;
begin
  Result := Self;
  var LDataSource := TDataSource.Create(nil);
  try
    FConn.Query('SELECT * FROM api.EMPRESAS',[],LDataSource);

    LDataSource.DataSet.First;
    while not LDataSource.DataSet.Eof do
    begin
      var LEmpresa := TEmpresa.Create;

      LEmpresa.Id := LDataSource.DataSet.FieldByName('ID').AsString;
      LEmpresa.Nome := LDataSource.DataSet.FieldByName('Nome').AsString;
      LEmpresa.Telefone := LDataSource.DataSet.FieldByName('Telefone').AsString;
      LEmpresa.Email := LDataSource.DataSet.FieldByName('Email').AsString;
      LEmpresa.InscricaoEstadual := LDataSource.DataSet.FieldByName('INSCRICAOESTADUAL').AsString;
      LEmpresa.InscricaoEstadualST := LDataSource.DataSet.FieldByName('INSCRICAOESTADUALST').AsString;
      LEmpresa.CRT := LDataSource.DataSet.FieldByName('CRT').AsInteger;
      LEmpresa.Logotipo := LDataSource.DataSet.FieldByName('LOGOTIPO').AsString;
      LEmpresa.Regime := LDataSource.DataSet.FieldByName('REGIME').AsInteger;

      var LDatasourceEndereco := TDataSource.Create(nil);
      var LEndereco := TEndereco.Create;
      try
        FConn.Query(Format('select * from enderecos where empresa = s%', [LEmpresa.Id]),
          [],LDatasourceEndereco);
        LEndereco.Id := LDatasourceEndereco.DataSet.FieldByName('ID').AsString;
        LEndereco.Empresa := LDatasourceEndereco.DataSet.FieldByName('EMPRESA').AsString;
        LEndereco.Logradouro := LDatasourceEndereco.DataSet.FieldByName('LOGRADOURO').AsString;
        LEndereco.Numero := LDatasourceEndereco.DataSet.FieldByName('NUMERO').AsString;
        LEndereco.Complemento := LDatasourceEndereco.DataSet.FieldByName('COMPLEMENTO').AsString;
        LEndereco.Bairro := LDatasourceEndereco.DataSet.FieldByName('BAIRRO').AsString;
        LEndereco.Cidade := LDatasourceEndereco.DataSet.FieldByName('CIDADE').AsString;
        LEndereco.Estado := LDatasourceEndereco.DataSet.FieldByName('ESTADO').AsString;
        LEndereco.Cep := LDatasourceEndereco.DataSet.FieldByName('CEP').AsString;
        LEndereco.CreatedAt := LDatasourceEndereco.DataSet.FieldByName('created_at').AsDateTime;
        LEndereco.UpdatedAt := LDatasourceEndereco.DataSet.FieldByName('updated_at').AsDateTime;

        LEmpresa.Endereco := LEndereco;
      finally
        LDataSource.Free;
      end;

      var LDataSourceEmissor := TDataSource.Create(nil);
      var LEmissorFiscal := TEmissorFiscal.Create;
      try
        FConn.Query(Format('select * from emissores_fiscais where empresa = s%', [LEmpresa.Id]),
          [],LDataSourceEmissor);
        LEmissorFiscal.Id := LDataSourceEmissor.DataSet.FieldByName('ID').AsString;
        LEmissorFiscal.Empresa := LEmpresa.Id;
        LEmissorFiscal.TipoDoumentoFiscal := LDataSourceEmissor.DataSet.FieldByName('tipo_documento_fiscal').AsString;
        LEmissorFiscal.Ambiente := LDataSourceEmissor.DataSet.FieldByName('ambiente_emissor').AsString;
        LEmissorFiscal.Serie := LDataSourceEmissor.DataSet.FieldByName('serie_emissao').AsString;
        LEmissorFiscal.Numero := LDataSourceEmissor.DataSet.FieldByName('numero_nota_fiscal').AsString;
        LEmissorFiscal.TipoEmissao := LDataSourceEmissor.DataSet.FieldByName('tipo_emissao').AsString;
        LEmissorFiscal.TipoSped := LDataSourceEmissor.DataSet.FieldByName('tipo_sped').AsString;
        LEmissorFiscal.Certificado := TStringStream.Create(LDataSourceEmissor.DataSet.FieldByName('certificado_digital').Asstring);
        LEmissorFiscal.Senha := LDataSourceEmissor.DataSet.FieldByName('senha').AsString;

        LEmpresa.EmissorFiscal := LEmissorFiscal;
      finally
        LDataSourceEmissor.Free;
      end;

      FEmpresas.Add(LEmpresa);
      LEmpresa.Free;
      LEndereco.Free;
      LDataSource.DataSet.Next;
    end;
  finally
    LDataSource.Free;
  end;
end;

function TRepositoryEmpresa.ListarPorId(Value: String): IRepository<TEmpresa>;
begin
  Result := Self;
  var LDataSource := TDataSource.Create(nil);
  try
    FConn.Query('select * from empresas where id = :id',[Value],LDataSource);
    FEmpresa.Id := LDataSource.DataSet.FieldByName('ID').AsString;
    FEmpresa.Nome := LDataSource.DataSet.FieldByName('Nome').AsString;
    FEmpresa.Telefone := LDataSource.DataSet.FieldByName('Telefone').AsString;
    FEmpresa.Email := LDataSource.DataSet.FieldByName('Email').AsString;
    FEmpresa.InscricaoEstadual := LDataSource.DataSet.FieldByName('INSCRICAOESTADUAL').AsString;
    FEmpresa.InscricaoEstadualST := LDataSource.DataSet.FieldByName('INSCRICAOESTADUALST').AsString;
    FEmpresa.CRT := LDataSource.DataSet.FieldByName('CRT').AsInteger;
    FEmpresa.Logotipo := LDataSource.DataSet.FieldByName('LOGOTIPO').AsString;
    FEmpresa.Regime := LDataSource.DataSet.FieldByName('REGIME').AsInteger;

    var LDatasourceEndereco := TDataSource.Create(nil);
    var LEndereco := TEndereco.Create;
    try
      FConn.Query('select * from enderecos where empresa = :empresa', [FEmpresa.Id],LDatasourceEndereco);
      LEndereco.Id := LDatasourceEndereco.DataSet.FieldByName('ID').AsString;
      LEndereco.Empresa := LDatasourceEndereco.DataSet.FieldByName('EMPRESA').AsString;
      LEndereco.Logradouro := LDatasourceEndereco.DataSet.FieldByName('LOGRADOURO').AsString;
      LEndereco.Numero := LDatasourceEndereco.DataSet.FieldByName('NUMERO').AsString;
      LEndereco.Complemento := LDatasourceEndereco.DataSet.FieldByName('COMPLEMENTO').AsString;
      LEndereco.Bairro := LDatasourceEndereco.DataSet.FieldByName('BAIRRO').AsString;
      LEndereco.Cidade := LDatasourceEndereco.DataSet.FieldByName('CIDADE').AsString;
      LEndereco.Estado := LDatasourceEndereco.DataSet.FieldByName('ESTADO').AsString;
      LEndereco.Cep := LDatasourceEndereco.DataSet.FieldByName('CEP').AsString;
      LEndereco.CreatedAt := LDatasourceEndereco.DataSet.FieldByName('created_at').AsDateTime;
      LEndereco.UpdatedAt := LDatasourceEndereco.DataSet.FieldByName('updated_at').AsDateTime;

      FEmpresa.Endereco := LEndereco;
    finally
      LDataSource.Free;
    end;

    var LDataSourceEmissor := TDataSource.Create(nil);
    var LEmissorFiscal := TEmissorFiscal.Create;
    try
      FConn.Query(Format('select * from emissores_fiscais where empresa = s%', [FEmpresa.Id]),
        [],LDataSourceEmissor);
      LEmissorFiscal.Id := LDataSourceEmissor.DataSet.FieldByName('ID').AsString;
      LEmissorFiscal.Empresa := FEmpresa.Id;
      LEmissorFiscal.TipoDoumentoFiscal := LDataSourceEmissor.DataSet.FieldByName('tipo_documento_fiscal').AsString;
      LEmissorFiscal.Ambiente := LDataSourceEmissor.DataSet.FieldByName('ambiente_emissor').AsString;
      LEmissorFiscal.Serie := LDataSourceEmissor.DataSet.FieldByName('serie_emissao').AsString;
      LEmissorFiscal.Numero := LDataSourceEmissor.DataSet.FieldByName('numero_nota_fiscal').AsString;
      LEmissorFiscal.TipoEmissao := LDataSourceEmissor.DataSet.FieldByName('tipo_emissao').AsString;
      LEmissorFiscal.TipoSped := LDataSourceEmissor.DataSet.FieldByName('tipo_sped').AsString;
      LEmissorFiscal.Certificado := TStringStream.Create(LDataSourceEmissor.DataSet.FieldByName('certificado_digital').Asstring);
      LEmissorFiscal.Senha := LDataSourceEmissor.DataSet.FieldByName('senha').AsString;

      FEmpresa.EmissorFiscal := LEmissorFiscal;
    finally
      LDataSourceEmissor.Free;
    end;

    FEmpresas.Add(FEmpresa);
    FEmpresa.Free;
    LEndereco.Free;
  finally
    LDataSource.Free;
  end;
end;

class function TRepositoryEmpresa.New: IRepository<TEmpresa>;
begin
  Result := Self.Create;
end;

function TRepositoryEmpresa.These: TObjectList<TEmpresa>;
begin
  Result := FEmpresas;
end;

function TRepositoryEmpresa.This: TEmpresa;
begin
  Result := FEmpresa;
end;

end.
