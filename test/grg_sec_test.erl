-module('grg_sec_test').
-include_lib("eunit/include/eunit.hrl").

gen_timestamp_test() ->
    {ok, GrgSecPid} = grg_sec:start_link(),
    lists:map(fun(_) ->
		      io:fwrite("~B~n", [grg_sec:gen_timestamp(3)])
	      end, lists:seq(1, 10)),
    gen_server:stop(GrgSecPid),
    %?assert(false),
    ok.
