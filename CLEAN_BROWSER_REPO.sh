#!/bin/bash

set -e

echo
echo "====================================================="
echo "CREATING CLEAN ARCHIVE STRUCTURE"
echo "====================================================="
echo

mkdir -p ARCHIVE/minimap2
mkdir -p ARCHIVE/synteny
mkdir -p ARCHIVE/old_trackdb
mkdir -p ARCHIVE/failed_lastz
mkdir -p ARCHIVE/extra_rnaseq

# =====================================================
# MOVE OLD MINIMAP2 TRACKS
# =====================================================

mv data/H0_GNM_vs_H2.bb ARCHIVE/minimap2/ 2>/dev/null || true
mv data/H1_GNM_vs_H2.bb ARCHIVE/minimap2/ 2>/dev/null || true
mv data/H13_GNM_vs_H2.bb ARCHIVE/minimap2/ 2>/dev/null || true
mv data/H15_GNM_vs_H2.bb ARCHIVE/minimap2/ 2>/dev/null || true
mv data/H17_GNM_vs_H2.bb ARCHIVE/minimap2/ 2>/dev/null || true
mv data/H19_GNM_vs_H2.bb ARCHIVE/minimap2/ 2>/dev/null || true
mv data/H24_GNM_vs_H2.bb ARCHIVE/minimap2/ 2>/dev/null || true
mv data/H25_GNM_vs_H2.bb ARCHIVE/minimap2/ 2>/dev/null || true

# =====================================================
# MOVE OLD SYNTENY TRACKS
# =====================================================

mv data/*synteny.bb ARCHIVE/synteny/ 2>/dev/null || true

# =====================================================
# MOVE FAILED CLEAN TRACKDB
# =====================================================

mv H2_trackdb_clean.txt ARCHIVE/old_trackdb/ 2>/dev/null || true
mv H2_trackdb.txt.backup_dense_tracks ARCHIVE/old_trackdb/ 2>/dev/null || true

# =====================================================
# MOVE REDUNDANT RNA FILE
# =====================================================

mv data/SRR5819939_rpm.bw ARCHIVE/extra_rnaseq/ 2>/dev/null || true

# =====================================================
# CREATE FINAL CLEAN TRACKDB
# =====================================================

cat > H2_trackdb.txt << 'TRACKS'

track H2_gene_annotation
longLabel Trichoplax sp. H2 NCBI gene annotation
shortLabel H2 Genes
bigDataUrl data/H2.bigGenePred
type bigGenePred
priority 1
visibility full

track H2_RNAseq
longLabel Trichoplax sp. H2 transcriptome
shortLabel H2 transcriptome
bigDataUrl data/SRR5819939.bigWig
type bigWig
priority 2
visibility full
color 113,188,104
autoScale on

# =====================================================
# ORIGINAL WORKING LEGACY TRACKS
# =====================================================

track h1
shortLabel h1
longLabel LAST alignment of H1 to H2
bigDataUrl data/h1_vs_h2.bb
type bigBed 6
visibility dense
priority 10
color 0,0,255

track h4
shortLabel h4
longLabel LAST alignment of H4 to H2
bigDataUrl data/h4_vs_h2.bb
type bigBed 6
visibility dense
priority 11
color 80,80,255

track h6
shortLabel h6
longLabel LAST alignment of H6 to H2
bigDataUrl data/h6_vs_h2.bb
type bigBed 6
visibility dense
priority 12
color 120,120,255

track h11
shortLabel h11
longLabel LAST alignment of H11 to H2
bigDataUrl data/h11_vs_h2.bb
type bigBed 6
visibility dense
priority 13
color 0,180,255

track h13
shortLabel h13
longLabel LAST alignment of H13 to H2
bigDataUrl data/h13_vs_h2.bb
type bigBed 6
visibility dense
priority 14
color 180,0,255

# =====================================================
# NEW HSP-STYLE LASTZ TRACKS
# =====================================================

track h0HSP
shortLabel h0HSP
longLabel HSP-style LASTZ occupancy alignment of H0 to H2
bigDataUrl data/H0_GNM_vs_H2.hspLastz.bb
type bigBed 6
visibility dense
priority 20
color 255,0,0

track h15HSP
shortLabel h15HSP
longLabel HSP-style LASTZ occupancy alignment of H15 to H2
bigDataUrl data/H15_GNM_vs_H2.hspLastz.bb
type bigBed 6
visibility dense
priority 21
color 0,128,255

track h17HSP
shortLabel h17HSP
longLabel HSP-style LASTZ occupancy alignment of H17 to H2
bigDataUrl data/H17_GNM_vs_H2.hspLastz.bb
type bigBed 6
visibility dense
priority 22
color 0,200,0

track h19HSP
shortLabel h19HSP
longLabel HSP-style LASTZ occupancy alignment of H19 to H2
bigDataUrl data/H19_GNM_vs_H2.hspLastz.bb
type bigBed 6
visibility dense
priority 23
color 255,128,0

track h24HSP
shortLabel h24HSP
longLabel HSP-style LASTZ occupancy alignment of H24 to H2
bigDataUrl data/H24_GNM_vs_H2.hspLastz.bb
type bigBed 6
visibility dense
priority 24
color 180,0,255

track h25HSP
shortLabel h25HSP
longLabel HSP-style LASTZ occupancy alignment of H25 to H2
bigDataUrl data/H25_GNM_vs_H2.hspLastz.bb
type bigBed 6
visibility dense
priority 25
color 120,120,120

TRACKS

echo
echo "====================================================="
echo "FINAL CLEAN BROWSER STATE"
echo "====================================================="
echo

echo
echo "ACTIVE TRACKDB:"
echo "H2_trackdb.txt"

echo
echo "ACTIVE DATA FILES:"
ls data/*.bb

echo
echo "ARCHIVED FILES:"
find ARCHIVE | head -50

echo
echo "DONE"
echo

