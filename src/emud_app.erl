%%%-------------------------------------------------------------------
%% @doc emud public API
%% @end
%%%-------------------------------------------------------------------

-module(emud_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    emud_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
