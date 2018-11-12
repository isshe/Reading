package main

import "golang.org/x/tour/pic"
import (
	"image"
	"image/color"
)

type Image struct{
	x, y, w, h int
	v uint8
}

func (im Image)Bounds() image.Rectangle {
	return image.Rect(0, 0, im.w, im.h)
}

func (im Image)ColorModel() color.Model {
	return color.RGBAModel
}

func (im Image)At(x, y int) color.Color{
	return color.RGBA{im.v, im.v, 255, 255}
}

func main() {
	m := Image{0, 0, 100, 100, 1}
	pic.ShowImage(m)
}
