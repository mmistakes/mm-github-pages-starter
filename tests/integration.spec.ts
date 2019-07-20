#!/usr/bin/env ts-node

import test  from 'tstest'

import fs from 'fs'
import util from 'util'

import probeImageSize from 'probe-image-size'
import globCB from 'glob'

import { prNumberToTitle } from '../src/pr-number-to-title'

const glob = util.promisify(globCB)

const isPR = require('is-pr')

test.skip('pull request title', async t => {
  if (isPR) {
    const prNum = parseInt(process.env['TRAVIS_PULL_REQUEST'] as string)
    const prTitle = await prNumberToTitle('bupt', 'ai-ml.club', prNum)

    if (prTitle.match(/(oral|poster)/i)) {
      // > 🗣Oral | 📰Poster - Paper Title
      t.true(prTitle.match(/^(🗣|📰)/), 'Oral or Poster should be started from 🗣 or 📰')
    } else {
      t.skip('Not a Oral or Poster PR, skipped')
    }
  } else {
    t.skip('skipped because this test is not ran from a pull request')
  }
})

test('image size should not more than 1MB', async t => {
  const MAX_WIDTH = 1920         // HD
  const MAX_SIZE  = 1024 * 1024  // 1MB

  const fileList = await glob('docs/assets/**/*.{jpg,jpeg,png}')
  t.true(fileList.length > 0, 'should get image file list')

  for (const file of fileList) {
    const dim = await probeImageSize(fs.createReadStream(file))
    const size = fs.statSync(file)['size']

    if (dim.width > MAX_WIDTH || size > MAX_SIZE) {
      t.fail(`${file} exceed the max limit: width: ${dim.width}, size: ${size}. use "./scripts/fit-image.sh <FILE>" to adjust it fit.`)
    }
  }
})
