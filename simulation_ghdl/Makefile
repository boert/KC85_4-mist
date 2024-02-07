LIBRARY_LIST=$(shell grep --invert '^\s*$\|^#\|^\s*#' ../vhdl_files.txt | cut -f 1 -d" " | sort | uniq)
FILE_LIST=$(shell grep --invert '^\s*$\|^#\|^\s*#' ../vhdl_files.txt | cut -f 2 -d" " | awk '{printf "../%s\n",$$1,$$2}')
FILE_LIST_WORK=$(shell grep --invert '^\s*$\|^#\|^\s*#' ../vhdl_files.txt | grep ^work | cut -f 2 -d" " | awk '{printf "../%s\n",$$1,$$2}')
FILE_LIST_T80=$(shell grep --invert '^\s*$\|^#\|^\s*#' ../vhdl_files.txt | grep ^T80 | cut -f 2 -d" " | awk '{printf "../%s\n",$$1,$$2}')
FILE_LIST_TTLLIB=$(shell grep --invert '^\s*$\|^#\|^\s*#' ../vhdl_files.txt | grep ^ttl_lib | cut -f 2 -d" " | awk '{printf "../%s\n",$$1,$$2}')

TOP_TB = taktgeber_tb
TOP_TB = top_mist_tb
TOP_TB = top_kc85_4_tb

# ghdl options
OPTS = --std=08

all: run


analyze:
	@echo "Librarys: $(LIBRARY_LIST)"
	ghdl -a --work=T80     $(OPTS) $(FILE_LIST_T80)
	ghdl -a --work=ttl_lib $(OPTS) $(FILE_LIST_TTLLIB)
	ghdl -a --work=work    $(OPTS) $(FILE_LIST_WORK)

compile: analyze
	ghdl -c $(OPTS) $(FILE_LIST)

elaborate: analyze
	ghdl -e $(OPTS) $(TOP_TB)

run: elaborate
	ghdl -r $(OPTS) $(TOP_TB) --vcd=wave.vcd


view: wave.vcd
	gtkwave wave.vcd --save=wave_$(TOP_TB).gtkw


clean:
	ghdl --clean
	rm -f *.cf
	rm -f *.o
	rm -f $(TOP_TB)
	rm -f wave.vcd


