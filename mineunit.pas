unit mineunit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, mineunit2, Vcl.StdCtrls, Vcl.Menus, system.types,
  Vcl.ExtCtrls;

type
  Tm_button = class(Tbutton)
    public
      num_data : integer;
      is_click : integer;
  end;
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    Option1: TMenuItem;
    configuration1: TMenuItem;
    N1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure m_buttonclick(sender: tobject);
    procedure m_buttonmouseUp(Sender: TObject; Button :TMouseButton; Shift :Tshiftstate; X:integer; y:integer);
    procedure configuration1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  board : array of integer;
  count_array : array[0..7] of integer;
  m_button : array of Tm_button;
  is_start : integer = 0;
  button_count : integer;
  mine_num : integer = 10;
  mine_count : integer;
  board_width : integer = 9;
  board_height : integer = 9;
  mine_num_temp : integer = 10;
  board_width_temp : integer = 9;
  board_height_temp :integer = 9;

procedure button_lock();

implementation

{$R *.dfm}

uses mineunit3;

procedure button_lock();
var
  i :integer;
begin
  for i := 0 to (board_width+2)*(board_height+2)-1 do
    m_button[i].is_click := 1;
  //Tform1.Label1.caption := 'You Lose!';

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, j, k :integer;
begin
  if is_start = 1 then
  begin
  for i := 0 to (board_width+2)*(board_height+2)-1 do
    m_button[i].free;
  end;

  board_width := board_width_temp;
  board_height := board_height_temp;
  mine_num := mine_num_temp;

  count_array[0] := 0-(board_width+3);
  count_array[1] := 0-(board_width+2);
  count_array[2] := 0-(board_width+1);
  count_array[3] := -1;
  count_array[4] := 1;
  count_array[5] := board_width+1;
  count_array[6] := board_width+2;
  count_array[7] := board_width+3;

  setlength(board, (board_width+2)*(board_height+2));
  setlength(m_button, (board_width+2)*(board_height+2));

  clear_board(board,board_width,board_height);
  set_board_wall(board,board_width,board_height);
  set_mine(board,board_width,board_height, mine_num);
  set_number(board,board_width,board_height);
  for i := 0 to board_height + 1 do
    for j := 0 to board_width + 1 do
      begin
        k := i*(board_width+2)+j;

        m_button[k] := Tm_button.Create(self);
        m_button[k].Parent := self;
        m_button[k].Height := 25;
        m_button[k].Width := 25;
        m_button[k].top := 100 + i * 25;
        m_button[k].left := 25 + j * 25;
        m_button[k].num_data := k;

        m_button[k].is_click := 0;
        m_button[k].enabled := true;
        m_button[k].Caption := '';
        if board[m_button[k].num_data] = 100 then
        begin
           m_button[k].enabled := false;
           m_button[k].is_click := 1;
        end;
        //m_button[k].OnClick := m_buttonclick;
        m_button[k].OnMouseUp := m_buttonmouseUp;
      end;
  button_count := board_width*board_height-mine_num;
  mine_count := mine_num;
  label1.Caption := '##MineSweep##';
  label2.Caption := inttostr(mine_count);
  is_start := 1;

end;


procedure TForm1.configuration1Click(Sender: TObject);
begin
  mineunit3.Form2 := Tform2.Create(application);
  if mineunit3.form2.showmodal = mrok then
  begin
    board_width_temp := mineunit3.board_width;
    board_height_temp := mineunit3.board_height;
    mine_num_temp := mineunit3.mine_num;
  end;
  mineunit3.Form2.Free;
end;


procedure TForm1.m_buttonclick(sender: tobject);
var
  temp : integer;
  i : integer;
begin
if (sender as Tm_button).is_click = 0 then
  begin
  temp := (sender as Tm_button).num_data;
  if (board[temp]>0) and (board[temp]<10) then
    (sender as Tm_button).caption := inttostr(board[temp])
  else if (board[temp]=0) then
    (sender as Tm_button).caption := ''
  else if (board[temp]=10) then
    begin
    //(sender as Tm_button).Caption := '@';
    button_lock();
    for i := 0 to (board_width+2)*(board_height+2)-1 do
      if board[i] = 10 then
        m_button[i].Caption := '@';
    label1.Caption := 'You Lose!';
    exit;
    end;

  (sender as Tm_button).Enabled := false;
  (sender as Tm_button).is_click := 1;

  if board[temp] = 0 then
    for i := 0 to 7 do
      if m_button[temp+count_array[i]].is_click = 0 then
        m_buttonclick(m_button[temp+count_array[i]]);

  button_count := button_count - 1;

  if (button_count <= 0) and (mine_count = 0) then
    begin
      button_lock();
      label1.Caption := 'You Win!';
    end;

  end;
end;

procedure TForm1.m_buttonmouseUp(Sender: TObject; Button: TMouseButton;
  Shift: Tshiftstate; X, y: integer);
  var
    temp : integer;
    i : integer;
    count : integer;
begin
  if (button = mbright) and (button = mbleft) then
  begin
  end
  else if (button = mbleft) then
  begin
    m_buttonclick(sender as Tm_button);
  end
  else if (button = mbright) then
  begin
    if (sender as Tm_button).is_click = 0 then
    begin
    (sender as Tm_button).caption := 'M';
    mine_count := mine_count -1;
    label2.Caption := inttostr(mine_count);
    (sender as Tm_button).is_click := 2;
    end
    else if (sender as Tm_button).is_click = 2 then
    begin
    (sender as Tm_button).caption := '';
    mine_count := mine_count +1;
    label2.Caption := inttostr(mine_count);
    (sender as Tm_button).is_click := 0;
    end;

  end;
end;

end.
