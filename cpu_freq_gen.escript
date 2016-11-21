#!/usr/bin/env escript
%% -*- erlang -*-
%%! -pa ebin

main([Verbose, CntStr]) ->
    rand:seed(exs1024),
    Target = "cpu0",
    {Count, _} = string:to_integer(CntStr),
    Tuples =
	repeat(Count, fun() ->
			      EventSpecs = grg_sec:gen_timestamp(),
			      ProcSecs = grg_sec:gen_timestamp(rand:uniform(5)) + 3,
			      Percentage = 55 + rand:uniform(40),
			      Tuple = { EventSpecs, ProcSecs, Percentage },
			      on_verbose_do(Verbose, fun() -> io:fwrite("generate: ~p~n", [Tuple]) end),
			      timer:sleep(rand:uniform(3000)),
			      Tuple
		      end),
    lists:map(fun({EventSpecs, ProcSecs, Percentage}) ->
		      io:fwrite("~s { \"timestamp\": ~p, \"target\": ~p, \"percentage\": ~p }~n",
				[grg_to_seconds(ProcSecs),
				 grg_to_seconds(EventSpecs),
				 Target,
				 Percentage])
	      end, lists:sort(Tuples));
main([CntStr]) ->
    main(["", CntStr]).

%% show_paths() ->
%%     lists:foreach(fun(E) ->
%% 			  io:format("Path ~s ~n", [E])
%% 		  end, code:get_path()).

repeat(N, Closure) ->
    lists:map(fun(_) -> Closure() end, lists:seq(1, N)).

on_verbose_do(State, Closure) when State == "--verbose" orelse State == "-v" ->
    Closure();
on_verbose_do(_, _) ->
    ok.

grg_to_seconds(GregorianSeconds) ->
    {{Y, M, D}, {H, Mn, S}} = calendar:gregorian_seconds_to_datetime(GregorianSeconds),
    lists:flatten(io_lib:fwrite("~4..0B/~2..0B/~2..0B ~2..0B:~2..0B:~2..0B", [Y, M, D, H, Mn, S])).
