# Define PETSC_DIR to ~/petsc if it's not defined
ifdef PETSC_DIR
else
PETSC_DIR = $(HOME)/petsc
endif

include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules

INCFLAGS = -I${PETSC_DIR}/include -I${PETSC_DIR}/${PETSC_ARCH}/include

SRC = src
SOURCEC = $(SRC)/main.cpp \
	$(SRC)/calc_drho.cpp \
	$(SRC)/calc_visc.cpp \
	$(SRC)/DM1.cpp \
	$(SRC)/DM1_v.cpp \
	$(SRC)/DMT.cpp \
	$(SRC)/DMv.cpp \
	$(SRC)/DMSwarm.cpp \
	$(SRC)/DMSwarm2mesh.cpp \
	$(SRC)/DMSwarm_move.cpp \
	$(SRC)/thermal_Ke.cpp \
	$(SRC)/reader.cpp \
	$(SRC)/veloc_total.cpp \
	$(SRC)/sp.cpp
OBJECTS = $(SOURCEC:%.cpp=%.o)

help:
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo "  all		Build and install Mandyoc by running"
	@echo "  test_mandyoc	Run the Mandyoc test using 2 cores. It takes several munutes"
	@echo ""

# Run test
test_mandyoc:
	@echo "Run MANDYOC test may take several minutes.."
	cd test/testing_data/ ; ${MPIEXEC} -n 2 ../../mandyoc
	pytest -v test/testing_result.py

# Build Mandyoc
all: ${OBJECTS} chkopts
	-${CLINKER} -o mandyoc ${OBJECTS} ${PETSC_LIB}
	rm $(SRC)/*.o

%.o: %.cpp
	${PCC} -Wall -fdiagnostics-color -c $< -o $@ ${INCFLAGS}
