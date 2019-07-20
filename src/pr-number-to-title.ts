import { FileBox } from 'file-box'

export async function prNumberToTitleByApi (
  org: string,
  repo: string,
  pr: number,
): Promise<string> {
  const fileBox = FileBox.fromUrl(
    // https://stackoverflow.com/a/34601082/1123955
    `https://api.github.com/repos/${org}/${repo}/pulls/${pr}`,
    'pr.json',
    {
      'User-Agent': 'FileBox',
    }
  )
  const prJsonText = (await fileBox.toBuffer()).toString()
  // console.log(prJsonText)
  const prJson = JSON.parse(prJsonText)
  const prTitle = prJson.title as string
  return prTitle
}

export async function prNumberToTitle (
  org: string,
  repo: string,
  pr: number,
): Promise<string> {
  const fileBox = FileBox.fromUrl(
    `https://github.com/${org}/${repo}/pull/${pr}`,
    'pr.json',
  )
  const prHtml = (await fileBox.toBuffer()).toString()
  // console.log(prHtml)

  const matches = prHtml.match(/<html.+?<head>.+?<title>(.+?) by .+? · Pull Request #\d+.+?<\/title>/si)
  if (!matches) {
    throw new Error('no matches for pr title')
  }
  const prTitle = matches[1]
  return prTitle
}
