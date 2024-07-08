# virtualScreeningOptimization

## Scripts and programs to facilitate the development of new task scheduling methods for virtual screening

### 1. Optimization problem

**Objective function:** the scoring function, an estimate of the target-ligand binding free energy (kcal/mol). 
Different programs for molecular docking use different scoring functions. The scoring function of AutoDock Vina 
is implemented in its [source code](https://github.com/ccsb-scripps/AutoDock-Vina) and presented in the paper 
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3041641/.

**Target** is a large molecule of complex shape (often a protein). **Ligand** is a small molecule capable of
binding to the target at a special place on its surface using intermolecular forces. Binding free energy is 
estimated using **molecular docking** - a computer modeling of 3D atomic models of the target and ligand that 
considers various possible positions of the ligand in the binding site of the target and includes the calculation 
of intermolecular and interatomic forces of their interactions.

Optimal position of a specific ligand in the binding site of a specific target
is achieved at the global minimum of their free energy of binding. One cannot calculate an exact global minimum 
on a computer (it is impossible to enumerate all possible ways of binding a ligand to a protein), thus various 
approximate algorithms are used. The value of the objective function depends on the chemical structures of the 
ligand and the target, the contributions of various molecular forces, the specific chosen mathematical function, 
the quality of computer models of the target and ligand, and the calculations error.

**Virtual screening** is a computerized procedure for performing molecular docking on large databases of ligands 
and selecting the **hits** among them - molecules that showed the best estimates of binding free energy with the
target. In virtual screening, one needs to find a number of local minima of the objective function on a set of ligands.
The value of the objective function correlates with the physicochemical properties of the ligands, so that similar ligands
often give close values. But there are also exceptions. For an expert who will analyze a set of hits, it is important not 
only to estimate the binding energy, but also their chemical diversity.

The chemical similarity of molecules is calculated using the Tanimoto coefficient - a measure of the similarity 
of two binary vectors, where each coordinate corresponds to the presence of a certain chemical property or structural
fragment. The closer to 1, the more similar the molecules are.

### 2. Papers

>[1] Natalia Nikitina, Evgeny Ivashko, Andrei Tchernykh. Congestion Game Scheduling for Virtual Drug Screening Optimization // Journal of Computer-Aided Molecular Design, Vol. 32, I. 2. 2018. Pp. 363-374.

The paper describes a task scheduling method for virtual screening which aims to find a balance between the number of interim hits and their chemical diversity, http://rdcu.be/CVPk (DOI: 10.1007/s10822-017-0093-7). 
A local copy is available [Submitted_JCAM_2017.pdf](Submitted_JCAM_2017.pdf).

### 3. Database preparation 

**GDB-9**, the database used in the computational experiments in paper [1], is an openly available database of 320K small organic molecules consisting of 9 and less atoms of C, O, N, S and Cl, not counting hydrogens. It is a subset of GDB-13. The molecules are stored as SMILES strings. The SMILES is the most compact format of molecular description. Most programs and utilities for molecule editing and visualisation accept the SMILES format.

Note that there exists another database GDB-9 (DOI: 10.1038/sdata.2014.22) that lists the molecules consisting of C, O, N and F atoms.

GDB-9 is a nice dataset to test the algorithms. More up-to-date GDB databases are available at https://zenodo.org/records/7041051. A local copy of GDB-9 is available at [gdb9_original.zip](gdb9_original.zip). One can also subset GDB-13 having downloaded it from the official source or an unofficial mirror (for example, https://huggingface.co/datasets/osbm/gdb_databases/tree/main). When using GDB-9 or GDB-13 in a published work, one should cite:
> _970 Million Druglike Small Molecules for Virtual Screening in the Chemical Universe Database GDB-13. Blum L. C.; Reymond J.-L. J. Am. Chem. Soc., 2009, 131, 8732-8733._

**AutoDock Vina** is an open-source program for molecular docking and virtual screening. Before performing virtual screening with AD Vina, several preparations of input files are needed. The input file format for AD Vina is PDBQT. This is a file describing molecular structure in 3D coordinates, therefore requiring much more disc space in comparison with compact file formats. 

> [!TIP]
> A version of GDB-9 prepared for molecular docking with AutoDock Vina is available at https://drive.google.com/drive/folders/1ccjqvMtQown56prDQNK-eQ87pQ11Z3m2?usp=sharing (gdb9_pdbqt.zip).

If one needs to prepare own files, please refer to the following information:

**OpenBabel** is a toolset of applications to analyze and process chemical data.

- obabel — files format conversion
- obgen — generation of 3D coordinates for a molecule 
- etc.

**MGLTools** is a set of applications to visualize and analyze molecular structures. Some of them are intended for virtual screening. 

- prepare_ligand4.py — preparation of a ligand file for virtual screening
- prepare_receptor4.py — preparation of a receptor file for virtual screening
- etc.

In order to generate PDBQT files from a SMILES set, one needs to perform conversion. Suppose that the file MOLECULES.smi contains a list of molecule descriptions in SMILES format. Generate PDBQT files: 

`obabel -ismi MOLECULES.smi -opdbqt -O MOLECULE.pdbqt -m --gen3d -h`

In case of an error "3D coordinate generation failed", try the following command:

`obabel -ismi MOLECULE.smi -ocan | obabel -ismi -h --gen2d -osdf | obabel -isdf --gen3d -h -opdbqt -O MOLECULE.pdbqt`

In order to calculate chemical properties of a molecule, one can use `obprop` utility:

`obprop MOLECULE.pdbqt`

Output example:

```
name             ligand_528
formula          C5
mol_weight       60.0535
exact_mass       60
canonical_SMILES [C][C][C][C]=[C]       ligand_528

InChI            InChI=1S/C5/c1-3-5-4-2

num_atoms        5
num_bonds        4
num_residues     1
num_rotors       2
sequence         UNL
num_rings        0
logP             0.4065
PSA              0
MR               16.215
$$$$
```
Here, we can see the calculated chemical properties mol_weight, exact_mass etc. 

> [!TIP]
> Calculated chemical properties of GDB-9 are available at https://drive.google.com/drive/folders/1ccjqvMtQown56prDQNK-eQ87pQ11Z3m2?usp=sharing (gdb9_properties.zip).

Next, one can divide the database into blocks in very different ways depending on the calculated properties. An example is given in paper [1].

> [!TIP]
> The division of GDB-9 into 16 blocks as described in paper [1] is available at [gdb9_paper_16blocks.txt](gdb9_paper_16blocks.txt). The data has the following structure: LIGAND_NAME NUM_ATOMS PSA BLOCK.


