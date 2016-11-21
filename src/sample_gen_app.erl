-module(sample_gen_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    sample_gen_sup:start_link().

stop(_State) ->
    ok.
