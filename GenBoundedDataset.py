# -*- coding: utf-8 -*-
"""
Created on Sat Dec 14 14:39:59 2019

@author: vital
"""

from PIL import Image
import os
import random
from pascal_voc_writer import Writer

    
    
HWMatrPath = './HandWrittenDataset\single'
PMatrPath = './PrintedDataset'
BGPath = './Backgrounds'

resultImgPath = './synthMultiMatr/img'
resultXmlPath = './synthMultiMatr/xml'
    
    


def generateSample(background, mList, numMatrices: int, fileName: str):
    bgW, bgH = background.size
    # Writer(path, width, height)
    writer = Writer(fileName, bgW, bgH)
    
    for i in 1..numMatrices:
        imgPath = random.choice(mList)
        img = Image.open(imgPath, 'r')
        imgW, imgH = img.size
        
        offset = ((bgW - imgW) // 2, (bgH - imgH) // 2)
        background.paste(img, offset)
        
        writer.addObject('cat', 100, 100, 200, 200)
        
        



    writer.save(fileName + ".xml")
    background.save(fileName)
        
    
def generateDataset(numSamples: int, setName: str, bgFolder: str, mFolder: str):
    bgList = os.listdir(bgFolder)
    mList = os.listdir(mFolder)
    
    for i in 1..numSamples:
        bgPath = random.choice(bgList)
        bgImg = Image.open(bgPath, 'r')
        
        numMatrices = random.randint(1, 8)
        fileName = setName + str(i)
        
        generateSample(bgImg, mList, numMatrices, fileName)
    
    
    

    

