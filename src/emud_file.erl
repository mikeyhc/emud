-module(emud_file).

-export([default_room_dir/0, list_rooms/0, load_room/1, load_rooms/0]).

default_room_dir() ->
    code:priv_dir(emud) ++ "/rooms".

list_rooms() ->
    list_erl_modules(default_room_dir()).

load_rooms() ->
    RoomDir = default_room_dir(),
    F = fun(Room) -> load_module(RoomDir ++ "/" ++ Room) end,
    {ok, lists:map(F, list_rooms())}.

load_room(Room) ->
    {ok, load_module(default_room_dir() ++ "/" ++ Room)}.

%% internal functions

drop_suffix(N, List) ->
    lists:reverse(lists:nthtail(N, lists:reverse(List))).

load_module(Path) ->
    {ok, Module} = compile:file(Path),
    Module.

list_erl_modules(Path) ->
    {ok, Filenames} = file:list_dir(Path),
    ErlFiles = lists:filter(fun(N) -> lists:suffix(".erl", N) end, Filenames),
    lists:map(fun(S) -> drop_suffix(4, S) end, ErlFiles).
