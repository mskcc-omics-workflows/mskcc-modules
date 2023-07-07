#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { SENTIEON_HAPLOTYPER as SENTIEON_HAPLOTYPER_VCF                   } from '../../../../../modules/nf-core/sentieon/haplotyper/main.nf'
include { SENTIEON_HAPLOTYPER as SENTIEON_HAPLOTYPER_GVCF                  } from '../../../../../modules/nf-core/sentieon/haplotyper/main.nf'
include { SENTIEON_HAPLOTYPER as SENTIEON_HAPLOTYPER_BOTH                  } from '../../../../../modules/nf-core/sentieon/haplotyper/main.nf'
include { SENTIEON_HAPLOTYPER as SENTIEON_HAPLOTYPER_INTERVALS_BOTH        } from '../../../../../modules/nf-core/sentieon/haplotyper/main.nf'
include { SENTIEON_HAPLOTYPER as SENTIEON_HAPLOTYPER_INTERVALS_DBSNP_BOTH  } from '../../../../../modules/nf-core/sentieon/haplotyper/main.nf'

workflow test_haplotyper_vcf {

    input     = [ [ id:'test' ], // meta map
                  file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true),
                  file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam_bai'], checkIfExists: true),
                  []  // no intervals
                ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    fai = file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)

    SENTIEON_HAPLOTYPER_VCF ( input, fasta, fai, [], [], 'variant', false)
}

workflow test_haplotyper_gvcf {

    input     = [ [ id:'test' ], // meta map
                  file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true),
                  file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam_bai'], checkIfExists: true),
                  []  // no intervals
                ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    fai = file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)

    SENTIEON_HAPLOTYPER_VCF ( input, fasta, fai, [], [], '', true)
}

workflow test_haplotyper_both {

    input     = [ [ id:'test' ], // meta map
                  file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true),
                  file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam_bai'], checkIfExists: true),
                  []  // no intervals
                ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    fai = file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)

    SENTIEON_HAPLOTYPER_BOTH ( input, fasta, fai, [], [], 'variant', true)
}

workflow test_haplotyper_intervals_both {

    input     = [ [ id:'test' ], // meta map
                  file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true),
                  file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam_bai'], checkIfExists: true),
                  file(params.test_data['homo_sapiens']['genome']['genome_bed'], checkIfExists: true)
                ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    fai = file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)

    SENTIEON_HAPLOTYPER_INTERVALS_BOTH ( input, fasta, fai, [], [], 'variant', true)
}

workflow test_haplotyper_intervals_dbsnp_both {

    input     = [ [ id:'test' ], // meta map
                  file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true),
                  file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam_bai'], checkIfExists: true),
                  file(params.test_data['homo_sapiens']['genome']['genome_bed'], checkIfExists: true)
                ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    fai = file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)

    dbsnp = file(params.test_data['homo_sapiens']['genome']['dbsnp_146_hg38_vcf_gz'], checkIfExists: true)
    dbsnp_tbi = file(params.test_data['homo_sapiens']['genome']['dbsnp_146_hg38_vcf_gz_tbi'], checkIfExists: true)

    SENTIEON_HAPLOTYPER_INTERVALS_DBSNP_BOTH (input, fasta, fai, dbsnp, dbsnp_tbi, 'variant', true)
}
