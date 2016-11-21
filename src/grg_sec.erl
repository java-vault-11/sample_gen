%% 
%% Generator for taking Gregorian-Seconds
%%
-module(grg_sec).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0]).
-export([gen_timestamp/0, gen_timestamp/1]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start_link() ->
    seed_random(),
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

seed_random() ->
    rand:seed(exs1024).

gen_timestamp() ->
    calendar:datetime_to_gregorian_seconds(calendar:now_to_universal_time(erlang:timestamp())).

gen_timestamp(DelaySeconds) ->
    calendar:datetime_to_gregorian_seconds(calendar:now_to_universal_time(erlang:timestamp()))
	+ rand:uniform(DelaySeconds) - 2.

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init(Args) ->
    {ok, Args}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

