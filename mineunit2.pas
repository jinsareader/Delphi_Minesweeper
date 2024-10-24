unit mineunit2;

interface
  function clear_board(var board:array of integer; board_width:integer; board_height:integer): integer;
  function set_board_wall(var board:array of integer; board_width:integer; board_height:integer): integer;
  function set_mine(var board:array of integer; board_width:integer; board_height:integer; mine_num : integer):integer;
  function set_number(var board:array of integer; board_width:integer; board_height:integer):integer;
  var
    board : array of integer;
    mine_num : integer;
    board_width : integer;
    board_height : integer;
    count : integer;
    count_array : array[0..7] of integer;
    i, j : integer;
implementation
  function clear_board(var board:array of integer; board_width:integer; board_height:integer): integer;
  begin
    for I := 0 to (board_width+2)*(board_height+2)-1 do
    begin
      board[i] := 0;

      result := 1;
    end;
  end;
  function set_board_wall(var board:array of integer; board_width:integer; board_height:integer): integer;
  begin
    for I := 0 to board_width+1 do
    begin
      board[i] := 100;
      board[i + (board_width+2)*(board_height+1)] := 100;
    end;
    for I := 0 to board_height+1 do
    begin
      board[i*(board_width+2)] := 100;
      board[i*(board_width+2)+(board_width+1)] := 100;
    end;

    result := 1;
  end;
  function set_mine(var board:array of integer; board_width:integer; board_height:integer; mine_num:integer): integer;
  var
    temp : integer;
  begin
    temp := 0;
    randomize;
    while (temp<mine_num) do
    begin
      while (True) do
      begin
        i := round(random((board_width+2)*(board_height+2)-1));
        if (board[i] = 0) then
          break;
      end;
      board[i] := 10;
      temp := temp + 1;
    end;

    result := 1;
  end;
  function set_number(var board:array of integer; board_width:integer; board_height:integer): integer;
  begin
    count_array[0] := 0-(board_width + 3);
    count_array[1] := 0-(board_width + 2);
    count_array[2] := 0-(board_width + 1);
    count_array[3] := -1;
    count_array[4] := 1;
    count_array[5] := (board_width +1);
    count_array[6] := (board_width +2);
    count_array[7] := (board_width +3);

    for I := 0 to (board_width+2)*(board_height+2)-1 do
    begin
      count := 0;
      if (board[i] = 0) then
      begin
        for j := 0 to 7 do
          if (board[i+count_array[j]] = 10) then
            count := count + 1;
        board[i] := count;
      end;
    end;

    result := 1;
  end;


end.
