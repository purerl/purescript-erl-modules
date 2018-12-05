
test: erl
	erl -pa ebin -noshell -eval '(test_main@ps:main())()' -eval 'init:stop()'

ps:
	psc-package sources | xargs purs compile 'src/**/*.purs' 'test/**/*.purs'

erl: ps
	mkdir -p ebin
	erlc -o ebin output/*/*.erl