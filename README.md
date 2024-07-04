# virtualScreeningOptimization

## Scripts and programs to facilitate the development of new task scheduling methods for virtual screening

### Задача оптимизации

**Целевая функция:** оценка свободной энергии связывания лиганда с мишенью (kcal/mol).
 
**Мишень** - крупная молекула сложной формы (часто - белок). **Лиганд** - малая молекула, способная
связываться с мишенью в специальном месте на ее поверхности при помощи сил межмолекулярного
взаимодействия. Свободная энергия связывания оценивается при помощи **молекулярного докинга** - 
компьютерного моделирования трехмерных атомарных моделей мишени и лиганда, учитывает различные возможные 
положения лиганда в сайте связывания мишени, включает в себя расчет сил межмолекулярного и межатомного 
взаимодействия между ними. 

Оптимальное положение конкретного лиганда в сайте связывания конкретной мишени
достигается в глобальном минимуме свободной энергии их связывания. Точно вычислить на компьютере
глобальный минимум (перебрать все возможные способы связывания лиганда с белком) невозможно,
используются различные приближенные алгоритмы. Таким образом, значение целевой функции зависит от
химической структуры лиганда и мишени, от вкладов различных молекулярных сил, от конкретной выбранной
математической функции, от качества компьютерных моделей мишени и лиганда и от погрешности вычислений.

**Виртуальный скрининг** - это компьютеризованная процедура проведения молекулярного докинга по большим 
базам лигандов и выбора среди них **хитов** - молекул, показавших наилучшие оценки энергии связывания с 
мишенью. При виртуальном скрининге нужно найти ряд локальных минимумов целевой функции на множестве лигандов.
Значение целевой функции коррелирует с физико-химическими свойствами лигандов, так что схожие лиганды
часто дают близкие значения. Но бывают и исключения. Для эксперта, который будет анализировать множество 
хитов, важна не только оценка энергии связывания, но также их химическое разнообразие. 

Химическое сходство молекул вычисляется при помощи коэффициента Танимото - это мера сходства двух бинарных 
векторов, где каждая координата соответствует наличию определенного химического свойства или структурного 
фрагмента. Чем ближе к 1, тем более схожи молекулы. 

### Papers

>[1] Natalia Nikitina, Evgeny Ivashko, Andrei Tchernykh. Congestion Game Scheduling for Virtual Drug Screening Optimization // Journal of Computer-Aided Molecular Design, Vol. 32, I. 2. 2018. Pp. 363-374.

The paper describes a task scheduling method for virtual screening which aims to find a balance between the number of interim hits and their chemical diversity, http://rdcu.be/CVPk (DOI: 10.1007/s10822-017-0093-7).

### Database preparation 

**GDB-9**, the database used in the computational experiments in paper [1], is an openly available database of 320K small organic molecules consisting of 9 and less atoms of C, O, N, S and Cl, not counting hydrogens. It is a subset of GDB-13. The molecules are stored as SMILES strings. The SMILES is the most compact format of molecular description. Most programs and utilities for molecule editing and visualisation accept the SMILES format.

Note that there exists another database GDB-9 (DOI: 10.1038/sdata.2014.22) that lists the molecules consisting of C, O, N and F atoms.

GDB-9 is a nice dataset to test the algorithms. More up-to-date GDB databases are available at https://zenodo.org/records/7041051. A local copy of GDB-9 is available [gdb9_original.zip](gdb9_original.zip). One can also subset GDB-13 having downloaded it from the official source or an unofficial mirror (for example, https://huggingface.co/datasets/osbm/gdb_databases/tree/main). When using GDB-9 or GDB-13 in a published work, one should cite:
> _970 Million Druglike Small Molecules for Virtual Screening in the Chemical Universe Database GDB-13. Blum L. C.; Reymond J.-L. J. Am. Chem. Soc., 2009, 131, 8732-8733._

**AutoDock Vina** is an open-source program for molecular docking and virtual screening. Before performing virtual screening with AD Vina, several preparations of input files are needed. The input file format for AD Vina is PDBQT. This is a file describing molecular structure in 3D coordinates, therefore requiring much more disc space in comparison with compact file formats. 

A version of GDB-9 prepared for molecular docking with AutoDock Vina is available [gdb9_prepared.zip](gdb9_prepared.zip). If one needs to prepare own files, please refer to the following information:

**OpenBabel** is a toolset of applications to analyze and process chemical data.

- obabel — files format conversion
- obgen — generation of 3D coordinates for a molecule 
- etc.

**MGLTools** is a set of applications to visualize and analyze molecular structures. Some of them are intended for virtual screening. 

- prepare_ligand4.py — preparation of a ligand file for virtual screening
- prepare_receptor4.py — preparation of a receptor file for virtual screening
- etc.

In order to generate PDBQT files from a SMILES set, one needs to perform conversion. Suppose that the file MOLECULES.smi contains a list of molecule descriptions in SMILES format. Generate PDBQT files: 

`obabel -ismi MOLECULES.smi -opdbqt -O MOLECULE.pdbqt -m --gen3D -h`


