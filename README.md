# virtualScreeningOptimization
## Scripts and programs to facilitate the development of new task scheduling methods for virtual screening.
### Papers

[1] The paper describing the task scheduling method for virtual screening which aims to find a balance between the number of interim hits and their chemical diversity: http://rdcu.be/CVPk (DOI: 10.1007/s10822-017-0093-7).

### Database preparation

**GDB-9**, the database used in the computational experiments in paper [1], is an openly available database of 320K small organic molecules consisting of 9 and less atoms of C, O, N, S and Cl, not counting hydrogens. The molecules are stored as SMILES strings. The SMILES is the most compact format of molecular description. Most programs and utilities for molecule editing and visualisation accept the SMILES format.

Note that there exists another database GDB-9 (DOI: 10.1038/sdata.2014.22) that lists the molecules consisting of C, O, N and F atoms.

As for 2024, GDB-9 seems to be outdated and not actively used in drug discovery. Still, it can serve as a nice dataset to test the algorithms. More up-to-date GDB databases are available at https://zenodo.org/records/7041051.

**AutoDock Vina** is an open-source program for molecular docking and virtual screening. Before performing virtual screening with AD Vina, several preparations of input files are needed. The input file format for AD Vina is PDBQT. This is a file describing molecular structure in 3D coordinates, therefore requiring much more disc space in comparison with compact file formats. 

**OpenBabel** is a toolset of applications to analyze and process chemical data.
    * obabel — files format conversion
    * obgen — generation of 3D coordinates for a molecule 
    * etc.

**MGLTools** is a set of applications to visualize and analyze molecular structures. Some of them are intended for virtual screening. 
    * prepare_ligand4.py — preparation of a ligand file for virtual screening
    * prepare_receptor4.py — preparation of a receptor file for virtual screening
    * etc.

In order to generate PDBQT files from a SMILES set, one needs to perform a series of steps. Suppose that the file MOLECULES.smi contains a list of molecule descriptions in SMILES format.

1. Generate 3D coordinates for all molecules in a file, SMILES → SDF
	obgen MOLECULES.smi > MOLECULES.sdf
2. Generate a separate PDB file for each molecule, SDF → PDB
	obabel -isdf MOLECULES.sdf -opdb -OMOLECULE.pdb -m
3. Prepare PDBQT file for docking (adding hydrogens as necessary etc.), PDB → PDBQT
	pythonsh prepare_ligand4.py -l MOLECULE.pdb -o MOLECULE.pdbqt -U \"""
