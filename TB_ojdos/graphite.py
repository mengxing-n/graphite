#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb 27 08:01:41 2018

@author: rday
"""

import numpy as np
import matplotlib.pyplot as plt
import chinook.build_lib as build_lib
import chinook.ARPES_lib as ARPES
import scipy.ndimage as nd
import chinook.operator_library as ops
import chinook.Tk_plot as Tk_plot
import chinook.klib as klib
import direct as integral



def write_file(tofile,arr):  
    
    with open(tofile,'w') as dest:
        
        for a in arr:
            line_wrt = ','.join(['{:0.8f}'.format(a[i]) for i in range(len(a))])+'\n'
            dest.write(line_wrt)
    dest.close()


def write_meta(to_meta,meta_dict):
    
    with open(to_meta,'w') as dest:
        line_wrt = 'kz: {:0.04f} 1/A \n'.format(meta_dict['kz'])
        line_wrt += 'hv: {:0.04f} eV \n'.format(meta_dict['hv'])
        line_wrt += 'State_lw: {:0.04f} eV \n'.format(meta_dict['s_lw'])
        line_wrt += 'Excitation_lw: {:0.04f} eV \n'.format(meta_dict['x_lw'])
        line_wrt += 'Eb: '+' '.join(['{:0.4f}'.format(meta_dict['Erange'][i]) for i in range(len(meta_dict['Erange']))])+'\n'
        line_wrt += 'kx: '+' '.join(['{:0.4f}'.format(meta_dict['kx'][i]) for i in range(len(meta_dict['kx']))])+'\n'
        line_wrt += 'ky: '+' '.join(['{:0.4f}'.format(meta_dict['ky'][i]) for i in range(len(meta_dict['ky']))])+'\n'

        dest.write(line_wrt)
    dest.close()

def write_bands(tobands,arr):
    with open(tobands,'w') as dest:
        for a in arr:
            line_wrt = ','.join(['{:0.8f}'.format(a[i]) for i in range(len(a))])+'\n'
            dest.write(line_wrt)
    dest.close()
    

if __name__=="__main__":
    a,c =  2.46,3.35
    avec = np.array([[np.sqrt(3)*a/2,a/2,0],
                      [np.sqrt(3)*a/2,-a/2,0],
                      [0,0,2*c]])
    
    filenm = 'graphite_test2.txt'
    CUT,REN,OFF,TOL=a*5,1,0.0,0.001
    
    G,M,K,H,L,A=np.zeros(3),np.array([0.5,0.5,0.0]),np.array([1./3,-1./3,0]),np.array([1./3,-1./3,0.5]),np.array([0.5,0.5,0.5]),np.array([0,0,0.5])
    G2,K2 = np.array([0,0,0.212]),np.array([1./3,-1./3,0.275])
#    G2 = np.array([0,0,3.783])
    spin = {'bool':False,'soc':False,'lam':{0:0.0}}

    Bd = {'atoms':[0,0,0,0],
			'Z':{0:6},
			'orbs':[["21z"],["21z"],["21z"],["21z"]],
			'pos':[np.array([0,0,0]),np.array([-a/np.sqrt(3.0),0,0]),np.array([0,0,c]),np.array([-a/(2*np.sqrt(3)),a/2,c])], #OK, consistent with model
            'spin':spin}
    #2.61 for original calculation 1.55,1.85
    kz = 0.4689
    Kd = {'type':'A',
		'avec':avec,
			'pts':[np.array([0,1.7,kz]),np.array([0,1.55,kz])],#[np.array([0,1.702,2.1]),np.array([0,1.702,3.68]),np.array([0,1.702,4.75])],
			'grain':200,
			'labels':['$\Gamma$','49.9','84']}


    Hd = {'type':'txt',
			'filename':filenm,
			'cutoff':CUT,
			'renorm':REN,
			'offset':OFF,
			'tol':TOL,
			'spin':spin}
 
    	#####
    Bd = build_lib.gen_basis(Bd)
    
    Kobj = build_lib.gen_K(Kd)
    TB = build_lib.gen_TB(Bd,Hd,Kobj)
    TB.solve_H()
    TB.plotting()



    kzi = np.linspace(2.595,2.615,5)
    meta_dict = {'kz':0,'hv':1.19,'s_lw':0.02,'x_lw':0.05,'kx':Kobj.kpts[:,0],'ky':Kobj.kpts[:,1]}

    
    for i in range(len(kzi)):
        TB.Kobj.kpts[:,-1] = kzi[i]
        meta_dict['kz'] = kzi[i]
        TB.solve_H()
        jdos = integral.path_dir_op(TB,TB.Kobj,meta_dict['hv'],meta_dict['x_lw'],10)
    #    
     #   Ix = integral.plot_jdos(TB.Kobj,TB,jdos,np.array([np.cos(np.pi*10/180),0,np.sin(np.pi*10/180)]))
        
    ##    Iy = integral.plot_jdos(Kobj,TB,jdos,np.array([0,1,0]))
    ##    Iz = integral.plot_jdos(Kobj,TB,jdos,np.array([0,0,1]))
    ###    
        Ixdos,_,endig = integral.k_integrated(TB.Kobj,TB,meta_dict['s_lw'],Ix)
        meta_dict['Erange'] = endig
        tofile = 'Graphite_JDOS_kz_{:0.04f}.txt'.format(kzi[i])
        metafile = 'Graphite_JDOS_kz_{:0.04f}_meta.txt'.format(kzi[i])
        tobands='Graphite_bands_kz_{:0.04f}.txt'.format(kzi[i])
        write_file(tofile,Ixdos)
        write_meta(metafile,meta_dict)
        write_bands(tobands,TB.Eband)



