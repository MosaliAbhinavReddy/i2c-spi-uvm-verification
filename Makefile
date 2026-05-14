QUESTA_HOME = /mnt/c/questasim64_2024.1/win64

VLIB     = $(QUESTA_HOME)/vlib.exe
VLOG     = $(QUESTA_HOME)/vlog.exe
VSIM     = $(QUESTA_HOME)/vsim.exe

RTL_DIR  = rtl
TB_DIR   = uvm_tb
WORK     = work

RTL_SRC  = $(RTL_DIR)/registerInterface.v \
            $(RTL_DIR)/serialInterface.v \
            $(RTL_DIR)/i2cSlave.v \
            $(RTL_DIR)/i2cSlaveTop.v

TB_TOP   = $(TB_DIR)/i2c_top.sv

UVM_TEST = i2c_test
UVM_VERB = UVM_MEDIUM

# ── default ───────────────────────────────────────────────────────────────────
all: lib comp_rtl comp_tb sim

# ── create work library ───────────────────────────────────────────────────────
lib:
	$(VLIB) $(WORK)

# ── compile RTL ───────────────────────────────────────────────────────────────
comp_rtl:
	$(VLOG) +incdir+$(RTL_DIR) $(RTL_SRC)

# ── compile UVM TB ────────────────────────────────────────────────────────────
comp_tb:
	$(VLOG) -sv +incdir+$(TB_DIR) -L mtiUvm $(TB_TOP)

# ── run (batch / no GUI) ──────────────────────────────────────────────────────
sim:
	$(VSIM) -c $(WORK).i2c_top \
	        -L mtiUvm \
	        +UVM_TESTNAME=$(UVM_TEST) \
	        +UVM_VERBOSITY=$(UVM_VERB) \
	        -do "run -all; quit -f"

# ── run with GUI + waveform ───────────────────────────────────────────────────
gui:
	$(VSIM) $(WORK).i2c_top \
	        -L mtiUvm \
	        -voptargs=+acc \
	        +UVM_TESTNAME=$(UVM_TEST) \
	        +UVM_VERBOSITY=$(UVM_VERB) \
	        -do "run -all"

# ── clean ─────────────────────────────────────────────────────────────────────
clean:
	rm -rf $(WORK) transcript vsim.wlf *.log

.PHONY: all lib comp_rtl comp_tb sim gui clean
